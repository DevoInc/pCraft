from pcraft.PluginsContext import PluginsContext
import time

class PCraftPlugin(PluginsContext):
    name = "Sleep"
    required = ["sleep"]
    
    def help(self):
        helpstr="""
Sleep a giving time in second

### Examples

#### 1: Sleep 3 seconds
```
sleep:
  _plugin: Sleep
  sleep: 3
  _next: done
```

#### 2: Sleep 0.1 seconds
```
sleep:
  _plugin: Sleep
  sleep: 0.1
  _next: done
```
"""
    
    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

    def run(self, script=None):
        self.check_required(script, self.required)

        time.sleep(int(self.getvar("sleep")))
        
        if script:
            return script["_next"], self.plugins_data
        else:
            return None, self.plugins_data
