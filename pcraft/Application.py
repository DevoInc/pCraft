import yaml
import re
import pprint

from pcraft.Plugins import *
from pcraft.Functions import *

class Application:
    def __init__(self, scenariofile):
        self.literals = ["rule"] # FIXME, this should be defined by plugins
        self.plugins_loader, self.loaded_plugins = self.load_plugins()
        self.loaded_functions = self.load_functions()
        self.scenariofile = scenariofile        
        self.script = self.load_script()
        self.variable_rex = re.compile(r"\$([a-zA-Z0-9-_]+)") # Find variables from scripts for replacement
        self.functions_rex = re.compile(r"=@=(.*?)=@=")
        
    def load_plugins(self):
        plugins_loader = Plugins(app=self, loadfunc=self.print_loading_plugins)
        loaded_plugins = plugins_loader.get_loaded_plugins()
        print("All plugins loaded!")
        return plugins_loader, loaded_plugins

    def load_functions(self):
        functions_loader = Functions(self.plugins_loader.get_plugins_data())
        loaded_functions = functions_loader.get_loaded_functions()
        print("All functions loaded!")
        return loaded_functions
    
    def print_loading_plugins(self, plugin):
        print("Loading Plugin: %s" % plugin)

    def load_script(self):
        script_fp = open(self.scenariofile)
        script = yaml.load(script_fp.read(), Loader=yaml.SafeLoader)
        script_fp.close()
        return script
    
    def exec_plugin(self, plugin, script):
        ans = None
        try:
            script = self.substitute_variables(script)
            script = self.substitute_function(script)
            ans = plugin.run(script)
        except(KeyError):
            # There is no input? Then there is no argument!
            ans = plugin.run()

        if not ans:
            print("Error, answer never gotten from plugin, which means there is an issue executing the script:")
            pprint.pprint(script)
        
        return ans

    def substitute_one_variable(self, value):
        if not isinstance(value, str):
            return value # We only replace strings!
        for match in self.variable_rex.finditer(value):
            m = match.group(1)
            try:
                sub = self.plugins_loader.get_plugins_data()._get(m)
            except KeyError:
                print("ERROR: Variable '%s' cannot be substituted since it has not been created before. Please fix your scenario." % m)
                sys.exit(1)
            value = value.replace("$"+m, sub, 1)
        
        return value

    def substitute_variables_from_dict(self, mydict, newdict, upk):
        for k, v in mydict.items():
            if isinstance(v, dict):
                self.substitute_variables_from_dict(v, newdict, k)
            else:
                try:
                    newdict[upk][k] = self.substitute_one_variable(v)
                except KeyError:
                    newdict[upk] = {}
                    newdict[upk][k] = self.substitute_one_variable(v)
        return newdict

    def substitute_variables(self, script):
        newscript = {}

        if script == None:
            return script
        
        for key, value in script.items():
            if isinstance(value, dict):
                # We have a dict from YAML, we recusively search for variables
                newdict = {}
                newdict = self.substitute_variables_from_dict(value, newdict, None)
                print("Adding the new dict to key:%s" % key)
                newscript[key] = newdict
            else:
                if not key.startswith("_"): # We add the variables in that script to be used right after
                    self.plugins_loader.get_plugins_data()._set(key, value)
                if key not in self.literals:
                    newscript[key] = self.substitute_one_variable(value)
                else:
                    print("info: key '%s' is considered literal. No variable replacement." % key)


        return newscript

    def substitute_function(self, script):
        newscript = {}

        if script == None:
            return script
        
        one_function_rex = re.compile(r"(\S+)\((.*)\)")
    
        for key, value in script.items():
            if isinstance(value, dict):
                print("dict not supported for function calls")
                return script
            else:
                matches = self.functions_rex.findall(value)
                if matches:
                    for m in matches:
                        #                print("Function: %s" % m)
                        single = one_function_rex.match(m)
                        if single:
                            function_name = single.group(1)
                            function_args = single.group(2)

                            funcout = self.loaded_functions[function_name].run(self.scenariofile, function_args)
                            value = value.replace("=@=" + m + "=@=", funcout, 1)
                        else:
                            raise ValueError("No matching function, replacement impossible. Please fix: %s" % m)
            newscript[key] = value

        return newscript

    

