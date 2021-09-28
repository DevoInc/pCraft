import pathlib
import os
import configparser

#
# A package is simply a directory which contains
# * The package name
# * A config directory where we find everything pcraft needs
#   to execute a plugin correctly
# * The binaries which work like a pipe mechanism leveraging Avro serialization
#
PCAP_CONF = "pcap.conf"
LOG_CONF = "log.conf"
DEPENDENCIES_CONF = "dependencies.conf"

class PackageManager(object):
    def __init__(self, pkgpath=None):
        self.debug = True
        self.pkgdir = pkgpath
        if not pkgpath:
            self.pkgdir = os.path.join(str(pathlib.Path(__file__).parent.parent.absolute()), "pkg", "enabled")
            if self.debug:
                print("Packages dir: %s" % self.pkgdir)

        # map between package name and actions
        self.actions_pkg_map = {}
                
        self.packages = {}
        for p in pathlib.Path(self.pkgdir).iterdir():
            if not p.is_dir():
                continue
            package_name = os.path.basename(p)
            self.packages[package_name] = {}
            self.packages[package_name]["dirpath"] = str(p)

        self.build_config()
        
    def get_packages(self):
        return self.packages

    def _foreach_config_file(self, confdir):
        for p in pathlib.Path(confdir).iterdir():
            if not p.is_dir():
                if str(p).endswith(".conf"):
                    yield p
        
    def build_config(self):
        for pkgname, pkgdata in self.packages.items():
            for conf in self._foreach_config_file(os.path.join(pkgdata["dirpath"], "conf")):
                if self.debug:
                    print("Reading configuration file: " + str(conf))
                parsed_conf = configparser.ConfigParser()
                conf_filename = pathlib.PurePosixPath(conf).name
                    
                try:
                    parsed_conf.read(conf)
                except configparser.MissingSectionHeaderError:
                    pass

                for section in parsed_conf.sections():
                    if conf_filename == PCAP_CONF:
                        self.actions_pkg_map[section] = pkgname
                    
                    for k, v in parsed_conf[section].items():                            
                        self.packages[pkgname]["config"] = {}
                        self.packages[pkgname]["config"][conf_filename] = {}
                        self.packages[pkgname]["config"][conf_filename][section] = {}
                        self.packages[pkgname]["config"][conf_filename][section][k] = v
                                            
    def get_config(self, pkgname):
        return self.packages[pkgname]["config"]

    # We want to get directly to the proper package for a given action plugin
    # for example, if the package mydns handles the DNSConnection plugin, it means
    # we want to know by giving "DNSConnection" as the action_plugin variable that it
    # exists in "mydns".
    def get_pkgname_from_action(self, action_plugin):
        return self.actions_pkg_map[action_plugin]
    
    
