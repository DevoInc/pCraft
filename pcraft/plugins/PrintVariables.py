from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "PrintVariables"
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

    def help(self):
        helpstr="""
This Plugins prints all the variables

### Example

The usage is trivial, just call it in your flow.

```
printvars:
  _plugin: PrintVariables

  _next: dnsconnect
```
"""
        return helpstr
        
    def run(self, script=None):
        self.update_vars_from_script(script)
        print("PrintVariables: " + str(self.plugins_data))
        return script["_next"], self.plugins_data
