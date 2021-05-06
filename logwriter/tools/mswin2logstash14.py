#!/usr/bin/env python3
from lxml import etree, objectify
import pprint
import json

def get_tag_nons(node):
    return etree.QName(node).localname

def parse_windows_event(eventfile):
    fp = open(eventfile, "r")
    xml = fp.read()

    root = etree.fromstring(xml)
    # print(get_tag_nons(root))

    winevent = {}    
    
    for section in root:
        # print("=====")
        section_tag = get_tag_nons(section.tag)
        winevent[section_tag] = {}
        # print(section_tag)
        # print(section.keys())
        for child in section.getchildren():
            # print(get_tag_nons(child.tag))
            child_tag = get_tag_nons(child.tag)
            keys = child.keys()
            if keys:
                if child.text:
                    if section_tag == "EventData":
                        winevent[section_tag][child.get("Name")] = child.text
                    else:
                        print("We have not seen events that do not belong to EventData having both an attribute and a text. Need to implement")
                else:
                    for k in keys:
                        built_key = child_tag + "_" + k
                        winevent[section_tag][built_key] = child.get(k)
                        # print("%s=>%s" % (k, child.get(k)))
            else:
                winevent[section_tag][child_tag] = child.text
            # print(child.text)

    return winevent
    
if __name__ == "__main__":
    winevent = parse_windows_event("event-4660.xml")
# {'EventData': {'HandleId': '0x1678',
#                'ObjectServer': 'Security',
#                'ProcessId': '0xef0',
#                'ProcessName': 'C:\\\\Windows\\\\explorer.exe',
#                'SubjectDomainName': 'CONTOSO',
#                'SubjectLogonId': '0x4367b',
#                'SubjectUserName': 'dadmin',
#                'SubjectUserSid': 'S-1-5-21-3457937927-2839227994-823803824-1104',
#                'TransactionId': '{00000000-0000-0000-0000-000000000000}'},
#  'System': {'Channel': 'Security',
#             'Computer': 'DC01.contoso.local',
#             'Correlation': None,
#             'EventID': '4660',
#             'EventRecordID': '270188',
#             'Execution_ProcessID': '4',
#             'Execution_ThreadID': '3060',
#             'Keywords': '0x8020000000000000',
#             'Level': '0',
#             'Opcode': '0',
#             'Provider_Guid': '{54849625-5478-4994-A5BA-3E3B0328C30D}',
#             'Provider_Name': 'Microsoft-Windows-Security-Auditing',
#             'Security': None,
#             'Task': '12800',
#             'TimeCreated_SystemTime': '2015-09-18T21:05:28.677152100Z',
#             'Version': '0'}}    
    # pprint.pprint(winevent)
    
    logstash14 = json.loads("""{
    "@metadata": {
      "beat": "winlogbeat",
      "type": "_doc",
      "version": "7.9.3"
    },
    "@timestamp": "",
    "agent": {
      "ephemeral": {
        "id": "c4f3deed-2933-2943-becb-ebc117bf648d"
      },
      "hostname": "WIN-N83MEGU",
      "id": "ff82fe3e-ccb3-39e0-beef-930415293fb8",
      "name": "WIN-N83MEGU",
      "type": "winlogbeat",
      "version": "7.9.3"
    },
    "ecs": {
      "version": "1.5.0"
    },
    "event": {
      "action": "Logon",
      "code": 4624,
      "created": "2021-05-04T19:12:36.000Z",
      "kind": "event",
      "outcome": "success",
      "provider": "Microsoft-Windows-Security-Auditing"
    },
    "host": {
      "name": "n83megu.example.com"
    },
    "log": {
      "file": {
        "path": "C:\\\\Logs\\\\logonid.evtx"
      },
    "level": "information"
    },
    "message": "An account was successfully logged on.\\n\\nSubject",
    "winlog": {
      "api": "wineventlog",
      "channel": "Security",
      "computer_name": "n83megu.example.com",
       "event_data": {
        },
      "event_id": 4624,
      "keywords_0": "Audit Success",
      "opcode": "Info",
      "process": {
        "pid": 632,
        "thread": {
          "id": 4244
        }
      },
    "provider_guid": "",
    "provider_name": "",
    "record_id": 2171290,
    "task": "Logon",
    "version": 2
    }
}""")

    logstash14["winlog"]["task"] = int(winevent["System"]["Task"])
    
    for k, v in winevent["EventData"].items():
        logstash14["winlog"]["event_data"][k] = v

    logstash14["event"]["code"] = int(winevent["System"]["EventID"])
        
    logstash14["winlog"]["computer_name"] = winevent["System"]["Computer"]
    logstash14["winlog"]["channel"] = winevent["System"]["Channel"]
    logstash14["winlog"]["event_id"] = int(winevent["System"]["EventID"])
    if logstash14["winlog"]["event_id"] == 4660:
        logstash14["message"] = "An object was deleted."
        
    logstash14["winlog"]["version"] = int(winevent["System"]["Version"])
    logstash14["@timestamp"] = winevent["System"]["TimeCreated_SystemTime"]
    logstash14["winlog"]["provider_guid"] = winevent["System"]["Provider_Guid"]
    logstash14["winlog"]["provider_name"] = winevent["System"]["Provider_Name"]
        
    print(json.dumps(logstash14))
     
