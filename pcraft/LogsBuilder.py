import os
import shutil
import sys

from avro.datafile import DataFileReader
from avro.io import DatumReader

from .confnames import *

class LogsBuilder(object):
    def __init__(self, pkg, ami_cache, log_folder, force=False):
        self.pkg = pkg
        self.ami_cache = ami_cache
        self.log_folder = log_folder
        self.avro_reader = DataFileReader(open(self.ami_cache, "rb"), DatumReader())
        self.file_pointers = {}
        self.generated_variables = {}
        
        self.build_outputdir(log_folder, force)
        self.no_log_module_for = {}
        
    def __del__(self):
        for k, v in self.file_pointers.items():
            v.close()

    def build_outputdir(self, outdir=None, force_mkdir=False):
        if not outdir:
            return None
        try:
            os.makedirs(outdir)
        except FileExistsError:
            if force_mkdir:
                shutil.rmtree(outdir)
                os.makedirs(outdir)
            else:
                print("Error: Cannot make directory %s: Directory already exists!" % outdir)
                self.has_error = True
                sys.exit(1)
        except:
            print("Error: Cannot make directory %s" % outdir)
            self.has_error = True
            sys.exit(1)

        return outdir
        
    def build(self):
        for event in self.avro_reader:
            original_event_variables = event["variables"].copy()
            # First we check for nested variables. When we assign a generated value to a variable
            for k, v in event["variables"].items():
                if v[0] == "$":
                    if v in self.generated_variables:
                        event["variables"][k] = self.generated_variables[v]
                        try:
                            event["generated_variables"][k] = v
                        except:
                            event["generated_variables"] = {}
                            event["generated_variables"][k] = v

                        
            for k, v in self.generated_variables.items():
                event["variables"][k] = v
                try:
                    event["generated_variables"][k] = v
                except:
                    event["generated_variables"] = {}
                    event["generated_variables"][k] = v
                
            is_log_action = False
            pkgname = event["exec"]
            packages_to_execute = []
            if pkgname.startswith("LogAction:"):
                log_action = pkgname[10:]
                try:
                    packages_to_look = self.pkg.get_pkgnames_from_log_action(log_action)
                except KeyError:
                    print("Error, Log action %s is called but no packages can handle it!" % log_action)
                    sys.exit(1)
                # Get the "event_log" from those packages now.
                for p in packages_to_look:
                    config = self.pkg.get_packages()[p]
                    for action, actionvals in config["config"][ACTIONS_CONF].items():
                        if action == log_action:
                            packages_to_execute.append(actionvals["event_log"])
                    
                is_log_action = True
            else:
                packages_to_execute.append(pkgname)

            new_pkg_to_execute = self._packages_to_execute_from_layers(packages_to_execute)
            # print("Packages to execute" + str(new_pkg_to_execute))
            
            for modexec in new_pkg_to_execute:
                # print("Action Package name:%s" % self.pkg.get_pkgname_from_action_log(modexec))
                logmod = self.pkg.get_log_module(modexec)
                if not logmod:
                    if modexec in self.no_log_module_for:
                        pass
                    else:
                        print("No log module for [%s]" % modexec)
                        self.no_log_module_for[modexec] = True
                    continue # We skip as this one will not log. Expected if this is just another type of package
                
                config = self.pkg.get_packages()[self.pkg.get_pkgname_from_action_log(modexec)]
                modconfig = config["config"]
                try:
                    template_name = modconfig[LOG_CONF][modexec]["template"]
                    templates = self._get_templates(self.pkg.get_pkgname_from_action_log(modexec), template_name)
                except KeyError:
                    # print("No template for %s" % modexec)
                    templates = []
                    templates.append({})

                # print("Executing %s" % modexec)
                if is_log_action:
                    actions_config = self._get_log_actions_config(self.pkg.get_pkgname_from_action_log(modexec))

                    events = actions_config[log_action]["event_id"].split(",")
                    event_log = None
                    try:
                        event_log = actions_config[log_action]["event_log"]
                    except:
                        print("Error, no event_log defined in actions.conf for Package %s" % modexec)
                        sys.exit(1)
                        
                    for e in events:
                        event["variables"]["$event_id"] = e
                        event = self._event_append_taxonomy_variables(event, modexec, modconfig)

                        for log in logmod.run(event, modconfig, templates[0]):
                            self._update_generated_variables(original_event_variables, event)
                            if log:
                                self._handle_log_write(event_log, modconfig, log)
                    # for k, v in actions_config[log_action].items():
                    #     events = v.split(",")
                    #     for e in events:
                    #         event["variables"]["$event_id"] = e

                    #         for log in logmod.run(event, modconfig, templates[0]):
                    #             self._handle_log_write(modexec, modconfig, log)
                else: # if log_action
                    try:
                        selected_template = templates[0]
                    except IndexError:
                        print("Error with template '%s' from package '%s'. Cannot load it. Maybe the event type (path) is wrong?" % (template_name, self.pkg.get_pkgname_from_action_log(modexec)))
                        sys.exit(1)

                    event = self._event_append_taxonomy_variables(event, modexec, modconfig)
                    for log in logmod.run(event, modconfig, selected_template):
                        self._update_generated_variables(original_event_variables, event)
                        if log:
                            self._handle_log_write(modexec, modconfig, log)


    def _packages_to_execute_from_layers(self, packages_to_execute):
        # Replace the packages to execute with their appropriate layers
        new_pkg_to_execute = []
        for modexec in packages_to_execute:
            writeslog =  False
            logmod = self.pkg.get_log_module(modexec)
            if not logmod:
                writeslog = True

            layer = self.pkg.get_pcap_layer_reverse_modules(modexec)
            if layer:
                if writeslog == False:
                    new_pkg_to_execute.append(modexec)

                # We have a layer? We have an IP packet!
                ip_modules = self.pkg.get_log_layer_modules("ip")
                if ip_modules:
                    for l in ip_modules:
                        new_pkg_to_execute.append(l)

                layer_modules = self.pkg.get_log_layer_modules(layer)
                if layer_modules:
                    for l in layer_modules:
                        new_pkg_to_execute.append(l)
            else:
                new_pkg_to_execute.append(modexec)   

        return new_pkg_to_execute
                
    def _event_append_taxonomy_variables(self, event, pkgname, config):
        # 'taxonomy.conf': {'fields': {'username': 'winlog_event_data_SubjectUserName,winlog_event_data_TargetUserName'}
        if not TAXONOMY_CONF in config:
            return event
        if "fields" in config[TAXONOMY_CONF]:
            for pcraftfield, pkgfields in config[TAXONOMY_CONF]["fields"].items():
                fieldsarray = pkgfields.split(",")
                variable_pcraftfield = "$" + pcraftfield
                for f in fieldsarray:
                    variablef = "$" + f
                    # if not variablef in event["variables"]:
                    if variable_pcraftfield in event["variables"]:
                        event["variables"][variablef] = event["variables"][variable_pcraftfield]
        
        return event
        
    def _update_generated_variables(self, original_event_variables, event):
        for k, v in event["variables"].items():
            if not k in original_event_variables:
                self.generated_variables[k] = v
        
    def _handle_log_write(self, pkgname, config, log):
        log_file = config[LOG_CONF][pkgname]["logfile"]
        if log_file in self.file_pointers:
            pass
        else:
            self.file_pointers[log_file] = open(os.path.join(self.log_folder, log_file), "wb")

        self.file_pointers[log_file].write(log)

    def _get_log_actions_config(self, pkgname):
        processes = {}
        packages = self.pkg.get_packages()
        return packages[pkgname]['config'][ACTIONS_CONF]

    def _get_log_processes_to_execute(self, pkgname):
        processes = {}
        packages = self.pkg.get_packages()
        for process, conf in packages[pkgname]['config'][LOG_CONF].items():
            conf["__basedir__"] = os.path.join(packages[pkgname]['dirpath'], "bin")
            processes[process] = conf
        return processes

    def _get_templates(self, pkgname, template_name):
        templates = self.pkg.get_templates(pkgname)
        # Select the template from the configuration
        template = []                
        for tmpl in templates:
            if tmpl["eventtype"] == template_name:
                template.append(tmpl)

        return template
