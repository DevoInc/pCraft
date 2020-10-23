#!/usr/bin/env python3
import sys

from gvgen import *
import pyami

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Syntax: %s script.ami" % sys.argv[0])
        sys.exit(1)

    amifile=sys.argv[1]
    amictx = pyami.Ami()
    amictx.Parse(amifile)
    actions = amictx.GetActions()

    graph = GvGen()    

    graph.styleAppend("Exec", "color", "#d8a814")
    graph.styleAppend("Exec", "style", "filled")
    graph.styleAppend("Exec", "shape", "rectangle")
    
    nodes = {}
    execs = {}
    
    previous_name = None
    for a in actions:
        name = a.Name()
        nodes[name] = graph.newItem(name)
        execs[a.Exec()] = graph.newItem(a.Exec(), nodes[name])
        graph.styleApply("Exec", execs[a.Exec()])
        if previous_name:
            graph.newLink(nodes[previous_name], nodes[name])
        previous_name = name

    graph.dot()

    
