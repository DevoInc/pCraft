class PluginsContext(object):
    def __init__(self, session, plugins_data):
        self.session = session
        self.plugins_data = plugins_data

    def getvar(self, var):
        return self.plugins_data._get(var)

    def setvar(self, var, value):
        self.plugins_data._set(var, value)
    
    def set_value_or_default(self, script, key, default):
        if key in script:
            value = script[key]
        else:
            try:
                value = self.plugins_data._get(key)
            except KeyError:
                value = default
                
        self.plugins_data._set(key, value)

    def check_required(self, script, required_keys):
        found_in_script=False
        found_in_plugins_data=False
        for k in required_keys:
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
        
