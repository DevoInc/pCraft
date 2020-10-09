#include <iostream>

#include <ami/action.h>

#include <pybind11/pybind11.h>

#include <action.hpp>

namespace py = pybind11;

Action::Action(void) {
  _action = ami_action_new();
}

Action::~Action(void) {
  ami_action_close(_action);
}
