#ifndef _AMIPP_H_
#define _AMIPP_H_

#include <vector>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>

#include <ami/ami.h>
#include <ami/action.h>

#include <action.hpp>

namespace py = pybind11;

class Ami {
public:
  Ami(void);
  ~Ami(void);
  int Parse(std::string file);
  void Debug(void);
  std::vector<Action*> actions;
  std::vector<Action*> GetActions(void);
private:
  ami_t *_ami;
  static void foreach_action(ami_action_t *action, void *userdata);  
};

#endif // _AMIPP_H_
