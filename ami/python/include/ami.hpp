#ifndef _AMIPP_H_
#define _AMIPP_H_

#include <vector>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/cache.h>

#include <action.hpp>

namespace py = pybind11;

class Ami {
public:
  Ami(void);
  ~Ami(void);
  int Cache(std::string amifile, std::string cachefile);
  int Parse(std::string file);
  int Run(py::object func, py::object userdata);
  void Debug(void);
  std::string GetFilePath(void) { return file_path; };
  std::string file_path;
  std::vector<std::string> GetReferences(void);
  std::vector<std::string> GetTags(void);
  float GetSleepCursor(void) { return _ami->sleep_cursor; };
  float GetGroupSleepCursor(std::string group) { return ami_get_new_sleep_cursor(_ami, group.c_str()); };
  void AppendSleepCursor(float s) { _ami->sleep_cursor += s; };
  void DebugSleepCursor(void) { ami_debug_sleep_cursor(_ami); };
  int GetStartTime(void) { return _ami->start_time; };
  char *GetTaxonomy(void) { return _ami->taxonomy; };
  int SetVariableString(std::string key, std::string value);
private:
  ami_t *_ami;
  static void foreach_action(ami_action_t *action, void *userdata1, void *userdata2, void *userdata3);  
};

#endif // _AMIPP_H_
