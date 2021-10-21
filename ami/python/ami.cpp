#include <iostream>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/ast.h>
#include <ami/cache.h>

#include <ami/khash.h>

#include <pybind11/pybind11.h>
#include <pybind11/functional.h>
#include <pybind11/stl.h>

#include <ami.hpp>

namespace py = pybind11;

void Ami::foreach_action(ami_action_t *amiaction, void *userdata, void *userdata2, void *userdata3)
{
  ami_field_action_t *field_action;
  khint_t k;
  
  py::object cb_func = *(py::object *)userdata2;
  py::object cbdata = *(py::object *)userdata3;

  Ami *pami = (Ami *)userdata;
  Action *action = new Action();
  action->set_name(ami_action_get_name(amiaction));
  action->set_exec(ami_action_get_exec(amiaction));
  action->sleep_cursor = amiaction->sleep_cursor + amiaction->sleep; // FIXME, We should use the _global group and add the local ones 
  action->repeat_index = amiaction->repeat_index;
  
  // ami_action_debug(pami->_ami, amiaction);
  if (amiaction->sleep_group) {
    for (k = 0; k < kh_end(amiaction->sleep_group); ++k) {
      if (kh_exist(amiaction->sleep_group, k)) {
	const char *key = kh_key(amiaction->sleep_group, k);
	float val = (float)kh_value(amiaction->sleep_group, k);
	action->sleep_group[key] = val;
      }
    }
  }
  
  if (pami->_ami->variables) {
    for (k = 0; k < kh_end(pami->_ami->variables); ++k) {
      if (kh_exist(pami->_ami->variables, k)) {
	const char *key = kh_key(pami->_ami->variables, k);
	ami_variable_t *var = (ami_variable_t *)kh_value(pami->_ami->variables, k);
	switch(var->type) {
	case AMI_VAR_STR:
	  action->variables[key] = var->strval;
	  break;
	case AMI_VAR_VARIABLE:
	  action->variables[key] = ami_get_nested_variable_as_str(pami->_ami, NULL, var->strval);
	  break;
	case AMI_VAR_INT:
	  char *tmpstr;
	  asprintf(&tmpstr, "%d", var->ival);
	  action->variables[key] = tmpstr;
	  break;
	}
      }
    }
  }

  if (amiaction->variables) {
    for (k = 0; k < kh_end(amiaction->variables); ++k) {
      if (kh_exist(amiaction->variables, k)) {
	const char *key = kh_key(amiaction->variables, k);
	ami_variable_t *var = (ami_variable_t *)kh_value(amiaction->variables, k);
	switch(var->type) {
	case AMI_VAR_STR:
	  action->variables[key] = var->strval;
	  break;
	case AMI_VAR_VARIABLE:
	  action->variables[key] = ami_action_get_nested_variable_as_str(amiaction, NULL, var->strval);
	  break;
	case AMI_VAR_INT:
	  char *tmpstr;
	  asprintf(&tmpstr, "%d", var->ival);
	  action->variables[key] = tmpstr;
	  break;
	}
      }
    }
  }

  
  for (field_action=amiaction->field_actions; field_action; field_action=field_action->next) {
    if (field_action->left) {
      action->field_actions[field_action->field][field_action->action][field_action->left] = field_action->right;
    } else {
      action->field_actions[field_action->field][field_action->action][field_action->right] = "";
    }
  }

  cb_func(action, cbdata);
}

Ami::Ami(void) {
  _ami = ami_new();
}

Ami::~Ami(void) {
  ami_close(_ami);
}

int Ami::Parse(std::string file) {
  int ret;

  file_path = file;
  
  ret = ami_parse_file(_ami, (char *)file.c_str());
  if (ret) {
    if (_ami->error) {
      std::cerr << "Error: " << ami_error_to_string(_ami) << std::endl;
      return 1;
    }
  }  

  return 0;
}

int Ami::Run(py::object func, py::object userdata) {
  ami_set_action_callback(_ami, foreach_action, this, &func, &userdata);

  ami_ast_walk_actions(_ami);
  
  // ami_debug(_ami);
  return 0;
}

void Ami::Debug(void) {
  ami_debug(_ami);
}

std::vector<std::string> Ami::GetReferences(void) {
  std::vector<std::string> references;
  ami_t *ami = _ami;
  
  size_t n_array = kv_size(ami->references);
  
  if (n_array > 0) {
    for (size_t i = 0; i < n_array; i++) {
      references.push_back(kv_A(ami->references, i));
    }
  }
  
  return references;
}

std::vector<std::string> Ami::GetTags(void) {
  std::vector<std::string> tags;
  ami_t *ami = _ami;
  size_t n_array = kv_size(ami->tags);
  
  if (n_array > 0) {
    for (size_t i = 0; i < n_array; i++) {
      tags.push_back(kv_A(ami->tags, i));
    }
  }
  
  return tags;
}

int Ami::Cache(std::string amifile, std::string cachefile)
{
  return ami_cache_build(amifile.c_str(), cachefile.c_str());
}

PYBIND11_MODULE(pyami, m) {
    m.doc() = "AMI Language for Python";
    py::class_<Ami>(m, "Ami")
      .def(py::init<>())
      .def("Cache", &Ami::Cache)
      .def("Parse", &Ami::Parse)
      .def("Run", &Ami::Run)
      .def("GetFilePath", &Ami::GetFilePath)
      .def("GetReferences", &Ami::GetReferences)
      .def("GetTags", &Ami::GetTags)
      .def("GetSleepCursor", &Ami::GetSleepCursor)
      .def("AppendSleepCursor", &Ami::AppendSleepCursor)
      .def("Debug", &Ami::Debug)
      .def("GetStartTime", &Ami::GetStartTime)
      .def("GetTaxonomy", &Ami::GetTaxonomy);
    py::class_<Action>(m, "Action")
      .def(py::init<>())
      .def("Variables", &Action::get_variables)
      .def("FieldActions", &Action::get_field_actions)
      .def("Name", &Action::get_name)
      .def("Exec", &Action::get_exec)
      .def("GetRepeatIndex", &Action::GetRepeatIndex)
      .def("GetSleepGroup", &Action::get_sleep_group)
      .def("GetSleepCursor", &Action::GetSleepCursor)
      .def("SetSleepCursor", &Action::SetSleepCursor);
}
