#include <stdio.h>
#include <stdlib.h>

#include <cpcapng/blocks.h>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>
#include <pybind11/stl.h>

#include "pycapng.hpp"

namespace py = pybind11;

PcapNg::PcapNg(void) {
  filename = NULL;
  
  // compression_level = 10;
  compression_level = 0;
}

PcapNg::~PcapNg(void) {
}

int PcapNg::OpenFile(const char *pathname, const char *mode)
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

int PcapNg::CloseFile(void)
{
  fflush(_fp);
  fclose(_fp);
  return 0;
}

int PcapNg::WritePacket(py::bytes data, const std::string &comment)  
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

int PcapNg::WriteCustom(uint32_t pen, py::bytes data, const std::string &comment)  
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

PYBIND11_MODULE(pycapng, m) {
    m.doc() = "cpcapng Python Bindings";
    py::class_<PcapNg>(m, "PcapNg")
      .def(py::init<>())
      .def("OpenFile", &PcapNg::OpenFile)
      .def("CloseFile", &PcapNg::CloseFile)
      .def("WriteCustom", &PcapNg::WriteCustom)
      .def("WritePacket", &PcapNg::WritePacket);
}



