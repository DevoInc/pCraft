class PluginsContext(object):
    def __init__(self, app, session, plugins_data):
        self.app = app
        self.session = session
        self.plugins_data = plugins_data

    def getvar(self, var):
        try:
            var = self.plugins_data._get(var)
            return var
        except KeyError:
            return None

    def setvar(self, var, value):
        self.plugins_data._set(var, value)

    def setvar_if_not_exists(self, var, value):
        a = self.getvar(var)
        if a:
            self.setvar(var, value)
        
    def set_value_or_default(self, action, key, default):
        value = None
        actions_variables = action.Variables()        
        try:
            varstr = "$" + key
            value = actions_variables[varstr]
            while value[0] == "$":
                value = actions_variables[value]
        except:
            value = default
                
        self.plugins_data._set(key, value)
        return value
        
    def check_required(self, script, required_keys):
        found_in_script=False
        found_in_plugins_data=False
        for k in required_keys:
            if script:
                if k in script:
                    found_in_script=True
            try:
                d = self.plugins_data._get(k)
                found_in_plugins_data=True
            except KeyError:
                pass
            
            if not found_in_script and not found_in_plugins_data:
                raise ValueError("Missing a required parameter. Needs: %s" % str(self.required))

        return True
        
    def update_vars_from_script(self, script):
        if not script:
            return
        for k, v in script.items():
            if not k.startswith("_"):
                self.setvar(k, v)

    def variable(self, varname, event=None):
        print("the variable function should not be called from PluginsContext!")
        pass
                
    def set_network_variables(self, vardict, event=None):
        if not "$port-src" in vardict:
            vardict["$port-src"] = self.variable("$port-src", event)
        if not "$port-dst" in vardict:
            vardict["$port-dst"] = self.variable("$port-dst", event)
        if not "$ip-src" in vardict:
            vardict["$ip-src"] = self.variable("$ip-src", event)
        if not "$ip-dst" in vardict:
            vardict["$ip-dst"] = self.variable("$ip-dst", event)
        if not "$protocol" in vardict:
            vardict["$protocol"] = self.variable("$protocol", event)
        
