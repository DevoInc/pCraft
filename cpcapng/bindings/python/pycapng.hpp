#ifndef _PCAPNGPP_H_
#define _PCAPNGPP_H_

#include <stdio.h>

#include <pybind11/pybind11.h>

namespace py = pybind11;

class PcapNg {
public:
  PcapNg(void);
  ~PcapNg(void);
  int OpenFile(const char *pathname, const char *mode);
  int CloseFile(void);
  int WritePacket(py::bytes data, const std::string &comment);
  int WriteCustom(uint32_t pen, py::bytes data, const std::string &comment);
  //
  int get_compression_level(void) { return compression_level; };
  char *get_filename(void) { return filename; };
private:
  FILE *_fp;
  char *filename;
  int compression_level;
};


#endif // _PCAPNGPP_H_
