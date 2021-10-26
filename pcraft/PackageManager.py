import pathlib
import os
import configparser
import importlib

from .TemplateBuilder import TemplateBuilder
from .confnames import *

#
# A package is simply a directory which contains
# * The package name
# * A config directory where we find everything pcraft needs
#   to execute a plugin correctly
# * The binaries which work like a pipe mechanism leveraging Avro serialization
#

class PackageManager(object):
    def __init__(self, pkgpath=None):
        self.debug = True
        self.pkgdir = pkgpath
        if not pkgpath:
            self.pkgdir = os.path.join(str(pathlib.Path(__file__).parent.parent.absolute()), "pkg", "enabled")
            if self.debug:
                print("Packages dir: %s" % self.pkgdir)

        # map between package name and actions (plugin to call)
        self.pcap_pkg_map = {}
        self.log_pkg_map = {}

        # map between package name and log actions (Auth.all -> WindowsSecurity etc.)
        self.log_actions_pkg_map = {}

        self.packages = {}
        for p in pathlib.Path(self.pkgdir).iterdir():
            if not p.is_dir():
                continue
            package_name = os.path.basename(p)
            self.packages[package_name] = {}
            self.packages[package_name]["dirpath"] = str(p)

        self.pcap_libraries = {}
        self.log_libraries = {}
            
        self.build_config()
        self.load_templates()
        self.load_libraries()
        
    def get_packages(self):
        return self.packages

    def _foreach_config_file(self, confdir):
        for p in pathlib.Path(confdir).iterdir():
            if not p.is_dir():
                if str(p).endswith(".conf"):
                    yield p

    def get_pcap_module(self, pkgname):
        if pkgname.startswith("LogAction:"):
            pkgname = "LogAction"
        
        if pkgname in self.pcap_libraries:
            return self.pcap_libraries[pkgname]
        return None

    def get_log_module(self, pkgname):
        if pkgname in self.log_libraries:
            return self.log_libraries[pkgname]
        return None

    def build_config(self):
        for pkgname, pkgdata in self.packages.items():
            self.packages[pkgname]["config"] = {}
            
            for conf in self._foreach_config_file(os.path.join(pkgdata["dirpath"], "conf")):
                if self.debug:
                    print("Reading configuration file: " + str(conf))
                parsed_conf = configparser.ConfigParser()
                conf_filename = pathlib.PurePosixPath(conf).name
                self.packages[pkgname]["config"][conf_filename] = {}
                    
                try:
                    parsed_conf.read(conf)
                except configparser.MissingSectionHeaderError:
                    pass

                for section in parsed_conf.sections():
                    if conf_filename == PCAP_CONF:
                        self.pcap_pkg_map[section] = pkgname

                    if conf_filename == LOG_CONF:
                        self.log_pkg_map[section] = pkgname
                        
                    if conf_filename == ACTIONS_CONF:
                        try:
                            self.log_actions_pkg_map[section].append(pkgname)
                        except:
                            self.log_actions_pkg_map[section] = []
                            self.log_actions_pkg_map[section].append(pkgname)                        
                        
                    for k, v in parsed_conf[section].items():
                        try:
                            self.packages[pkgname]["config"][conf_filename][section][k] = v
                        except KeyError:
                            self.packages[pkgname]["config"][conf_filename][section] = {}
                            self.packages[pkgname]["config"][conf_filename][section][k] = v
                            
    def get_config(self, pkgname):
        return self.packages[pkgname]["config"]

    # We want to get directly to the proper package for a given action plugin
    # for example, if the package mydns handles the DNSConnection plugin, it means
    # we want to know by giving "DNSConnection" as the action_plugin variable that it
    # exists in "mydns".
    def get_pkgname_from_action_pcap(self, action_plugin):
        return self.pcap_pkg_map[action_plugin]
    def get_pkgname_from_action_log(self, action_plugin):
        return self.log_pkg_map[action_plugin]

    def get_pkgnames_from_log_action(self, log_action):
        return self.log_actions_pkg_map[log_action]

    def load_libraries(self):
        print("Loading Libraries")
        current_wd = os.getcwd()
        for pkgname, pkgdata in self.packages.items():
            try:
                for lib, libdata in pkgdata["config"][PCAP_CONF].items():
                    pcap_library_path = os.path.join(pkgdata["dirpath"], "lib", libdata["lib"])
                    # print("Pcap Library Path:%s" % pcap_library_path)
                    plugin_name = lib
    
                    loading_path = pcap_library_path[len(current_wd)+1:].replace("/", ".")[:-3]
                    module = importlib.import_module(loading_path)
                    dylib = module.PcraftPcapWriter()
                    if lib in self.pcap_libraries:
                        print("Error with package '%s'; The library '%s' was previously defined by another package. It must be unique!" % (pkgname, lib))
                    self.pcap_libraries[lib] = dylib
            except:
                pass # No pcap library? all good!

            try:
                for lib, libdata in pkgdata["config"][LOG_CONF].items():
                    log_library_path = os.path.join(pkgdata["dirpath"], "lib", libdata["lib"])
                    # print("Log Library Path:%s" % log_library_path)
                    plugin_name = lib
    
                    loading_path = log_library_path[len(current_wd)+1:].replace("/", ".")[:-3]
                    print(loading_path)
                    module = importlib.import_module(loading_path)
                    dylib = module.PcraftLogWriter()
                    if lib in self.log_libraries:
                        print("Error with package '%s'; The library '%s' was previously defined by another package. It must be unique!" % (pkgname, lib))
                    self.log_libraries[lib] = dylib
            except:
                pass # No log library? all good!
            
        print("Done Loading Libraries")
    
    def load_templates(self):
        for pkgname, pkgdata in self.packages.items():
            templates_dir = os.path.join(pkgdata["dirpath"], "templates")

            tb = TemplateBuilder(templates_dir)
            self.packages[pkgname]["templates"] = tb.get_templates()
            
    def get_templates(self, pkgname):
        return self.packages[pkgname]["templates"]
    
