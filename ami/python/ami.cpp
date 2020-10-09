#include <iostream>

#include <ami/ami.h>
#include <ami/action.h>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>
#include <pybind11/stl.h>

#include <ami.hpp>

namespace py = pybind11;

void Ami::foreach_action(ami_action_t *amiaction, void *userdata)
{
  Ami *pami = (Ami *)userdata;
  Action *action = new Action();
  action->set_name(ami_action_get_name(amiaction));
  action->set_exec(ami_action_get_exec(amiaction));

  int varlen = ami_action_get_variables_len(amiaction);
  for (int i = 0; i < varlen; i++) {
    char *k = ami_action_get_variables_key_at_pos(amiaction, i);
    if (k) {
      std::string key = k;
      std::string value = ami_action_get_variable(amiaction, (char *)key.c_str());
      action->variables[key] = value;
    }
  }

  int replacelen = ami_action_get_replacement_len(amiaction);
  std::string replacefield = ami_action_get_replacement_field(amiaction);

  if (!replacefield.empty()) {
    for (int i = 0; i < replacelen; i++) {
      std::string key = ami_action_get_replacement_key_at_pos(amiaction, i);
      std::string value = ami_action_get_replacement_value_at_pos_with_ami(pami->_ami, amiaction, i);
      action->replacements[replacefield][key] = value;
    }
  }

  pami->actions.push_back(action);  
}

Ami::Ami(void) {
  _ami = ami_new();
}

Ami::~Ami(void) {
  ami_close(_ami);
}

std::vector<Action*> Ami::GetActions(void) {
  return actions;
}

int Ami::Parse(std::string file) {
  int ret;
  
  ami_set_action_callback(_ami, foreach_action, this);

  ret = ami_parse_file(_ami, (char *)file.c_str());
  if (ret) {
    if (_ami->error) {
      std::cerr << "Error: " << ami_error_to_string(_ami) << std::endl;
      return 1;
    }
  }
  
  ami_debug(_ami);
  return 0;
}

PYBIND11_MODULE(pyami, m) {
    m.doc() = "AMI Language for Python";
    py::class_<Ami>(m, "Ami")
      .def(py::init<>())
      .def("GetActions", &Ami::GetActions)
      .def("Parse", &Ami::Parse);
    py::class_<Action>(m, "Action")
      .def(py::init<>())
      .def("Variables", &Action::get_variables)
      .def("Replacements", &Action::get_replacements)
      .def("Name", &Action::get_name)
      .def("Exec", &Action::get_exec);

}
