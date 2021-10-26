#ifndef _PCAPNGPP_H_
#define _PCAPNGPP_H_

#include <stdio.h>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>

namespace py = pybind11;

class PcapNG {
public:
  PcapNG(void);
  ~PcapNG(void);
  int OpenFile(const char *pathname, const char *mode);
  int CloseFile(void);
  int WritePacket(py::bytes data, const std::string &comment);
  int WritePacketTime(py::bytes data, uint32_t timestamp);
  int WriteCustom(uint32_t pen, py::bytes data, const std::string &comment);
  int ForeachPacket(const py::object &func);
  //
  int get_compression_level(void) { return compression_level; };
  char *get_filename(void) { return filename; };
private:
  FILE *_fp;
  char *filename;
  int compression_level;

  static int foreach_packet_cb(uint32_t block_counter, uint32_t block_type, uint32_t block_total_length, unsigned char *data, void *userdata);
};

#endif // _PCAPNGPP_H_
