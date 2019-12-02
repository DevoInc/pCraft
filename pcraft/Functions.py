import glob
import importlib
import importlib.util
import os

import pcraft.functions

class Functions:
    def __init__(self, plugins_data, functionsdir="pcraft/functions/"):
        self.loaded_functions = {}
        self.functions = glob.glob(functionsdir + "*.py")
        self.functions = [x for x in self.functions if not x.endswith("__init__.py")] # I do not want to include the __init__.py file
        self.functions = [x for x in self.functions if not x.endswith("_utils.py")]
        if not self.functions:
            print("No functions could be loaded from %s." % functionsdir)
            return
        
        for modfile in self.functions:
            function_name = os.path.basename(modfile)[:-3] # We remove the extension
            import_function = self._modularize_string_path(modfile)
            module = importlib.import_module(import_function)
            dp = module.PCraftFunction(plugins_data)
            self.loaded_functions[function_name] = dp

    def _modularize_string_path(self, strpath):
        return strpath.replace("/",".")[:-3]

    def get_loaded_functions(self):
        return self.loaded_functions
