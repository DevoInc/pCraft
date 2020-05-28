from pcraft.PluginsContext import PluginsContext
from faker import Faker

class PCraftPlugin(PluginsContext):
    name = "FakeNames"
    required = []
    
    def help(self):
        helpstr="""
Create Fake Names

### Examples

#### 1: Fake Names
```
newfake:
  _plugin: FakeNames
  _next: done
```
"""

    def __init__(self, session, plugins_data):
        super().__init__(session, plugins_data)
        self.faker = Faker()
        
    def run(self, script=None):
        name = self.faker.name()
        nametable = name.split(" ") # Sometimes there are spaces in last names, we cut short and only grab the first one
        self.setvar("firstname", nametable[0])
        self.setvar("lastname", nametable[1])
        self.setvar("name", name)

        return script["_next"], self.plugins_data
