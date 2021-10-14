#include <stdio.h>
#include <stdlib.h>

#include <cpcapng/blocks.h>
#include <cpcapng/io.h>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>
#include <pybind11/stl.h>

#include "pycapng.hpp"

namespace py = pybind11;

PcapNG::PcapNG(void) {
  filename = NULL;
  
  // compression_level = 10;
  compression_level = 0;
}

PcapNG::~PcapNG(void) {
}

int PcapNG::OpenFile(const char *pathname, const char *mode)
{
  unsigned char *buffer;
  size_t buffer_size;

  if (!strcmp(mode, "w")) {
    _fp = fopen(pathname, "wb");
    if (!_fp) {
      fprintf(stderr, "Could not open file '%s' for writing!\n", pathname);
      return -1;
    }
    
    buffer_size = cpcapng_section_header_block_size();
    buffer = (unsigned char *)malloc(buffer_size);
    cpcapng_section_header_block_write(buffer);
    fwrite(buffer, buffer_size, 1, _fp);
    free(buffer);

    buffer_size = cpcapng_interface_description_block_size();
    buffer = (unsigned char *)malloc(buffer_size);
    cpcapng_interface_description_block_write(0, buffer);
    fwrite(buffer, buffer_size, 1, _fp);
    free(buffer);
  
    return 0;
  }

  if (!strcmp(mode, "r")) {
    _fp = fopen(pathname, "rb");
    if (!_fp) {
      fprintf(stderr, "Could not open file '%s' for reading!\n", pathname);
      return -1;
    }
    return 0;
  }

  fprintf(stderr, "Error opening file '%s' with mode '%s'. Supported modes are 'r' or 'w'.", pathname, mode);
  return -1;
}

int PcapNG::CloseFile(void)
{
  fflush(_fp);
  fclose(_fp);
  return 0;
}

int PcapNG::WritePacket(py::bytes data, const std::string &comment)  
{
  unsigned char *buffer;
  size_t buffer_size;

  py::buffer_info info(py::buffer(data).request());
  uint8_t *data_bytes = reinterpret_cast<uint8_t *>(info.ptr);
  size_t data_len = static_cast<size_t>(info.size);
  
  buffer_size = cpcapng_enhanced_packet_block_size(data_len);
  buffer = (unsigned char *)malloc(buffer_size);
  cpcapng_enhanced_packet_block_write(data_bytes, data_len, buffer);
  fwrite(buffer, buffer_size, 1, _fp);

  return 0;
}

int PcapNG::WriteCustom(uint32_t pen, py::bytes data, const std::string &comment)  
{
  unsigned char *buffer;
  size_t buffer_size;

  py::buffer_info info(py::buffer(data).request());
  uint8_t *data_bytes = reinterpret_cast<uint8_t *>(info.ptr);
  size_t data_len = static_cast<size_t>(info.size);
  
  buffer_size = cpcapng_custom_data_block_size(data_len);
  buffer = (unsigned char *)malloc(buffer_size);
  cpcapng_custom_data_block_write(pen, data_bytes, data_len, buffer);
  fwrite(buffer, buffer_size, 1, _fp);

  return 0;
}

int PcapNG::foreach_packet_cb(uint32_t block_counter, uint32_t block_type, uint32_t block_total_length, unsigned char *data, void *userdata)
{
  py::object cb_func = *(py::object *)userdata;

  uint32_t start_offset = cpcapng_custom_data_block_start_offset();
  uint32_t data_length = cpcapng_custom_data_block_data_length(block_total_length);
  
  int padded = cpcapng_padded_count(&data[start_offset], data_length);

  // FIXME: We just send the data but we will need to make this an object where we can retrieve the pen etc.
  cb_func(block_counter, block_type, block_total_length, py::bytes((const char *)&data[start_offset],
								   data_length - padded));

  return 0;
}

int PcapNG::ForeachPacket(const py::object &func)
{
  return cpcapng_fp_read(_fp, foreach_packet_cb, (void *)&func);
}

PYBIND11_MODULE(pycapng, m) {
    m.doc() = "cpcapng Python Bindings";

    // Our constants
    m.attr("ENHANCED_PACKET_BLOCK") = py::int_(PCAPNG_ENHANCED_PACKET_BLOCK);
    m.attr("CUSTOM_DATA_BLOCK") = py::int_(PCAPNG_CUSTOM_DATA_BLOCK);
    m.attr("INTERFACE_DESCRIPTION_BLOCK") = py::int_(PCAPNG_INTERFACE_DESCRIPTION_BLOCK);
    m.attr("PACKET_BLOCK") = py::int_(PCAPNG_PACKET_BLOCK);
    m.attr("SIMPLE_PACKET_BLOCK") = py::int_(PCAPNG_SIMPLE_PACKET_BLOCK);
    m.attr("NAME_RESOLUTION_BLOCK") = py::int_(PCAPNG_NAME_RESOLUTION_BLOCK);
    m.attr("INTERFACE_STATISTICS_BLOCK") = py::int_(PCAPNG_INTERFACE_STATISTICS_BLOCK);
    m.attr("ENHANCED_PACKET_BLOCK") = py::int_(PCAPNG_ENHANCED_PACKET_BLOCK);
    m.attr("IRIG_TIMESTAMP_BLOCK") = py::int_(PCAPNG_IRIG_TIMESTAMP_BLOCK);
    m.attr("ARINC_429_AFDX_ENCAP_BLOCK") = py::int_(PCAPNG_ARINC_429_AFDX_ENCAP_BLOCK);
    m.attr("SYSTEMD_JOURNAL_EXPORT_BLOCK") = py::int_(PCAPNG_SYSTEMD_JOURNAL_EXPORT_BLOCK);
    m.attr("DECRYPTION_SECRETS_BLOCK") = py::int_(PCAPNG_DECRYPTION_SECRETS_BLOCK);
    m.attr("HONE_PROJECT_MACHINE_INFO_BLOCK") = py::int_(PCAPNG_HONE_PROJECT_MACHINE_INFO_BLOCK);
    m.attr("HONE_PROJECT_CONNECTION_EVENT_BLOCK") = py::int_(PCAPNG_HONE_PROJECT_CONNECTION_EVENT_BLOCK);
    m.attr("SYSDIG_MACHINE_INFO_BLOCK") = py::int_(PCAPNG_SYSDIG_MACHINE_INFO_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V1_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V1_BLOCK);
    m.attr("SYSDIG_FD_LIST_BLOCK") = py::int_(PCAPNG_SYSDIG_FD_LIST_BLOCK);
    m.attr("SYSDIG_EVENT_BLOCK") = py::int_(PCAPNG_SYSDIG_EVENT_BLOCK);
    m.attr("SYSDIG_INTERFACE_LIST_BLOCK") = py::int_(PCAPNG_SYSDIG_INTERFACE_LIST_BLOCK);
    m.attr("SYSDIG_USER_LIST_BLOCK") = py::int_(PCAPNG_SYSDIG_USER_LIST_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V2_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V2_BLOCK);
    m.attr("SYSDIG_EVENT_WITH_FLAGS_BLOCK") = py::int_(PCAPNG_SYSDIG_EVENT_WITH_FLAGS_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V3_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V3_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V4_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V4_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V5_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V5_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V6_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V6_BLOCK);
    m.attr("SYSDIG_PROCESS_INFO_V7_BLOCK") = py::int_(PCAPNG_SYSDIG_PROCESS_INFO_V7_BLOCK);
    m.attr("CUSTOM_DATA_BLOCK") = py::int_(PCAPNG_CUSTOM_DATA_BLOCK);
    m.attr("CUSTOM_DATA_BLOCK_NOCOPY") = py::int_(PCAPNG_CUSTOM_DATA_BLOCK_NOCOPY);
    m.attr("SECTION_HEADER_BLOCK") = py::int_(PCAPNG_SECTION_HEADER_BLOCK);
    m.attr("TLS_KEY_LOG") = py::int_(PCAPNG_TLS_KEY_LOG);
    m.attr("WIREGUARD_KEY_LOG") = py::int_(PCAPNG_WIREGUARD_KEY_LOG);
    m.attr("ZIGBEE_NWK_KEY") = py::int_(PCAPNG_ZIGBEE_NWK_KEY);
    m.attr("ZIGBEE_APS_KEY") = py::int_(PCAPNG_ZIGBEE_APS_KEY);
    
    py::class_<PcapNG>(m, "PcapNG")
      .def(py::init<>())
      .def("OpenFile", &PcapNG::OpenFile)
      .def("CloseFile", &PcapNG::CloseFile)
      .def("WriteCustom", &PcapNG::WriteCustom)
      .def("WritePacket", &PcapNG::WritePacket)
      .def("ForeachPacket", &PcapNG::ForeachPacket);
}



