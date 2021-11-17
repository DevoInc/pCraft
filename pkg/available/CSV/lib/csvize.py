import sys

from pcraft.LibraryContext import *

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.is_first = True

    def run(self, event, config, templates):
        try:
            fields = event["variables"]["$csv_fields"].split(",")            
        except:
            print("Error: CSV plugin requires the $csv_fields variable with coma separated fields for variables we need to extract, such as $csv_fields = \"$foo, $bar\"")
            sys.exit(1)

        if not self.is_first:
            is_first = False
            row = ""
            for f in fields:
                if f == "$__time__":
                    var = "time"
                else:
                    var = str(f).replace("$", "")
                    var = var.replace("\"", "\\\"")
                row += var
                row += ","
            linerow = row[:len(row)-1] + "\n"
            yield bytes(str(linerow), "utf8")

        row = ""
        for f in fields:
            if f == "$__time__":
                var = str(event["time"])
            else:
                var = event["variables"][f]
                var = var.replace("\"", "\\\"")
            row += var
            row += ","

        linerow = row[:len(row)-1] + "\n"
            
        yield bytes(str(linerow), "utf8")
        
        yield None
