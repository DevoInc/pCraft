#!/usr/bin/env python3
import json
import pprint
import sys

class Attack2Dot():
    def __init__(self, attack_file, fd=sys.stdout):
        self.write_out = fd
        self.attack_file = attack_file
        self.tactics = {}
        self.techniques_ref = {} # References, such as T1156 and array of arrays for each name
        self.techniques_reverse_ref = {}
        self.techniques = {}
        self.attack_json = None

    def ParseAttackFile(self):
        self.fp = open(self.attack_file, "r")
        self.attack_json = json.load(self.fp)
        
        for item in self.attack_json["objects"]:
            is_subtec = False
            try:
                is_subtec = item["x_mitre_is_subtechnique"]
            except:
                pass

            if "revoked" in item:
                if item["revoked"] == True:
                    continue
    
            if "type" in item:
                if item["type"] == "x-mitre-tactic":
                    self.tactics[item["x_mitre_shortname"]] = item["name"]

                    
            if not is_subtec:
                if "kill_chain_phases" in item:
                    for phase in item["kill_chain_phases"]:
                        if phase["kill_chain_name"] == "mitre-attack":
                            try:
                                self.techniques[phase["phase_name"]].append(item["name"])
                            except KeyError:
                                self.techniques[phase["phase_name"]] = []
                                self.techniques[phase["phase_name"]].append(item["name"])    

                            if "external_references" in item:
                                refs = [] # There is only one ref, but who knows in the future?
                                for reference in item["external_references"]:
                                    if reference["source_name"] == "mitre-attack":
                                        refs.append(reference["external_id"])
                                try:
                                    self.techniques_ref[phase["phase_name"]].append(refs[0])
                                except KeyError:
                                    self.techniques_ref[phase["phase_name"]] = []
                                    self.techniques_ref[phase["phase_name"]].append(refs[0])
                                self.techniques_reverse_ref[refs[0]] = phase["phase_name"]
                                    

    def GetRefs(self):
        return self.techniques_ref

    def GetReverseRef(self, technique_id):
        return self.techniques_reverse_ref[technique_id]

    def GetRefIndex(self, tactic, technique_id):
        return self.techniques_ref[tactic].index(technique_id)
    
    def _graph_append_tactics(self, technique_name):
        label=""
        for i, t in enumerate(self.techniques[technique_name]):
            if i+1 < len(self.techniques[technique_name]):
                label += "<f" + str(i) + ">" + t + "|"
            else:
                label += "<f" + str(i) + ">" + t

        return label

    def _graph_create_subgraph(self, technique_label, technique_name):
        self.write_out.write("\tsubgraph cluster_%s {\n" % technique_name.replace("-", ""))
        # self.write_out.write("\t\tbgcolor=\"gray90\";\n")
        self.write_out.write("\t\tlabel=\"%s\";\n" % technique_label)
        self.write_out.write("\t\t" + technique_name.replace("-","") + " [label=\"" + self._graph_append_tactics(technique_name) + "\",shape=\"record\"];\n")
        self.write_out.write("\t}\n\n")

    def Dot(self, mapme):
        self.write_out.write("digraph G {\n")
        self.write_out.write("\trankdir=LR;\n")
        self._graph_create_subgraph("Reconnaissance", "reconnaissance")
        self._graph_create_subgraph("Resource Development", "resource-development")
        self._graph_create_subgraph("Initial Access", "initial-access")
        self._graph_create_subgraph("Execution", "execution")
        self._graph_create_subgraph("Persistence", "persistence")
        self._graph_create_subgraph("Privilege Escalation", "privilege-escalation")
        self._graph_create_subgraph("Defense Evasion", "defense-evasion")
        self._graph_create_subgraph("Credential Access", "credential-access")
        self._graph_create_subgraph("Discovery", "discovery")
        self._graph_create_subgraph("Lateral Movement", "lateral-movement")
        self._graph_create_subgraph("Collection", "collection")
        self._graph_create_subgraph("Command and Control", "command-and-control")
        self._graph_create_subgraph("Exfiltration", "exfiltration")
        self._graph_create_subgraph("Impact", "impact")
	
        prev = None
        for tactic, label in self.techniques.items():
            if not prev:
                prev = tactic.replace("-","")
                continue
            self.write_out.write("\t%s:f0 -> %s:f0 [style=invis];\n" % (prev, tactic.replace("-", "")))
            prev = tactic.replace("-","")


        prev = None
        counter = 1
        for item in mapme:
            strtac = item.split(".")
            technique_id = strtac[0]
            tactic = self.GetReverseRef(technique_id)
            technique_index = self.GetRefIndex(tactic, technique_id)
            tactic_id = tactic.replace("-","")
            if not prev:
                prev = "%s:f%d" % (tactic_id, technique_index)
                continue
            current = "%s:f%d" % (tactic_id, technique_index)
            self.write_out.write("\t%s -> %s [penwidth=4,color=\"red\",label=\"%d\",fontcolor=\"red\",fontsize=60];\n" % (prev, current, counter))
            prev = current
            counter += 1 
            
        self.write_out.write("}\n")


if __name__ == "__main__":

    tags=["T1205.001", "T1133", "T1021.004"]

    a2d = Attack2Dot("enterprise-attack.json")
    a2d.ParseAttackFile()
    a2d.Dot(tags)
    # print(a2d.GetRefs())

