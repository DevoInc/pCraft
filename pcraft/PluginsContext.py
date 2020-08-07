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
        
    def set_value_or_default(self, script, key, default):
        value = None
        if script:
            if key in script:
                value = script[key]

        if value == None:
            try:
                value = self.plugins_data._get(key)
            except KeyError:
                value = default
                
        self.plugins_data._set(key, value)

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
