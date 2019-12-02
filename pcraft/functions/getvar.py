class PCraftFunction(object):
    name = "getvar"
    
    def help(self):
        helpstr="""
Returns a variable
"""
        return helpstr

    def __init__(self, plugins_data):
        self.plugins_data = plugins_data

    def run(self, scenariofile, arguments):
        var = str(arguments)
        return self.plugins_data._get(var)
    
