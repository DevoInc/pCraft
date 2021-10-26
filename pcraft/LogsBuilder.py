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
        
        self.build_outputdir(log_folder, force)

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
        is_log_action = False
        
        for event in self.avro_reader:
            pkgname = event["exec"]
            packages_to_execute = []
            if pkgname.startswith("LogAction:"):
                log_action = pkgname[10:]
                packages_to_execute = self.pkg.get_pkgnames_from_log_action(log_action)
                is_log_action = True
            else:
                packages_to_execute.append(pkgname)

            for packagename in packages_to_execute:
                logmod = self.pkg.get_log_module(packagename)
                if not logmod:
                    print("Package module '%s' does not contain a log writer!" % event["exec"])
                    sys.exit(1)
                
                config = self.pkg.get_packages()[packagename]
                modconfig = config["config"]
                template_name = modconfig[LOG_CONF][packagename]["template"]
                templates = self._get_templates(packagename, template_name)

                if is_log_action:
                    actions_config = self._get_log_actions_config(packagename)
                    events = None
                    for k, v in actions_config[log_action].items():
                        events = v.split(",")
                        for e in events:
                            event["variables"]["$event_id"] = e
                            for log in logmod.run(event, modconfig, templates[0]):
                                self._handle_log_write(packagename, modconfig, log)
                else:
                    for log in logmod.run(event, modconfig, templates[0]):
                        self._handle_log_write(packagename, modconfig, log)

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
