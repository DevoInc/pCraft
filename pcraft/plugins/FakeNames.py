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

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.faker = Faker(['it_IT', 'en_US', 'es_ES', 'fr_FR', 'de_DE', 'en_GB'])
        self.fakenames = {}
        
    def run(self, script=None):
        no_infinite_loop = 0
        # We have see some duplicate names. We try 10 times to avoid spending too much time
        while no_infinite_loop < 10:
            name = self.faker.name()
            nametable = name.split(" ") # Sometimes there are spaces in last names, we cut short and only grab the first one
            first_last = "%s %s" % (nametable[0], nametable[1])        
            try:
                a = self.fakenames[first_last]
                break
            except KeyError: # Same player plays again!
              pass
            
            no_infinite_loop += 1
            
        self.setvar("firstname", nametable[0])
        self.setvar("lastname", nametable[1])        
        self.setvar("name", name)

        self.set_value_or_default(script, "orgdomain", "yoda.com")
        email = "%s.%s@%s" % (nametable[0], nametable[1], self.getvar("orgdomain"))
        self.setvar("email", email)

        return script["_next"], self.plugins_data
