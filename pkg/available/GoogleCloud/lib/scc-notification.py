import json
from datetime import datetime

from pcraft.LibraryContext import *

class SCCNotification():
    def __init__(self, utils, org="My Organization", detector_name="compromise_attempt", findingcategory="Initial Access: Compromise Attempt", referer_url="", request_url=None, request_ua=None):
        # Members we do not carry in the json output
        self.project_name = "infosec-shared-services-prod"
        self.project_id = utils.get_consistent_id(self.project_name, 12)
        self.org = org
        self.org_id = utils.get_consistent_id(self.org, 12)
        self.detector_name = detector_name
        self.findingcategory = findingcategory       
        self.referer_url = referer_url
        if not request_url:
            self.request_url = "/"
        else:
            self.request_url = request_url
        if not request_ua:
            self.request_ua = utils.get_random_user_agent()
        else:
            self.request_ua = request_ua
        
        self.utils = utils
        # End of members we must delete before serializing
        
        self.insertId = utils.gen_string(10)
        self.timestamp = "%Y-%m-%dT%H:%M:%S.000000Z"
        self.severity = "NOTICE"
        self.resource = {"resource": self.resource(detector_name) }
        self.logName = "projects/%s/logs/threatdetection.googleapis.com%%2Fdetection" % (self.project_name)
        self.receiveTimestamp = "%Y-%m-%dT%H:%M:%S.000000000Z"
        self.jsonPayload = self.jsonpayload()
        

    def resource(self, detector_name):
        resource = {}
        resource["type"] = "threat_detector"
        resource["labels"] = {"detector_name": detector_name, "project_id": self.project_name}
        return resource

    def jsonpayload(self):
        jsonpayload = { "access": {} }
        jsonpayload["affectedResources"] = self.jsonpayload_affectedresources()
        jsonpayload["contextUris"] = self.jsonpayload_contexturis()
        jsonpayload["detectionCategory"] = {"ruleName": self.detector_name }
        jsonpayload["detectionPriority"] = "LOW"
        jsonpayload["eventTime"] = "%Y-%m-%dT%H:%M:%S.000000Z"
        jsonpayload["evidence"] = self.jsonpayload_evidence()
        jsonpayload["findingCategory"] = self.findingcategory
        jsonpayload["findingId"] = self.utils.gen_md5()
        jsonpayload["mitreAttack"] = {}
        jsonpayload["properties"] = self.jsonpayload_properties()
        jsonpayload["sourceId"] = self.jsonpayload_sourceid()
        return jsonpayload

    def jsonpayload_affectedresources(self):
        affectedresources = []
        res = {"gcpResourceName": "//cloudresourcemanager.googleapis.com/projects/%s" % self.project_id}
        affectedresources.append(res)
        return affectedresources

    def jsonpayload_contexturis(self):
        contexturis = {}
        contexturis["cloudLoggingQueryUri"] = []
        cloudloggingqueryuri = {"displayName": "Cloud Logging Query Link",
                                "url": "https://console.cloud.google.com/logs/query;query=timestamp%%3D%%22{timestamp}%%22%%0AinsertId%%3D%%22{insertid}%%22%%0Aresource.labels.project_id%%3D%%22{projectid}%%22?project={projectname}".format(
                                    timestamp = self.timestamp,
                                    insertid = self.insertId,
                                    projectid = self.project_id,
                                    projectname = self.project_name
                                )
                                }
        # contexturis["mitreUri"] = {"displayName": "MITRE Link",
        #                            "url": "https://attack.mitre.org/techniques/T1234/"}
        contexturis["relatedFindingUri"] = {}

        return contexturis

    def jsonpayload_evidence(self):
        evidence = []
        evidence_sourcelogid = {}
        evidence_sourcelogid["sourceLogId"] = { "insertId": self.insertId,
                                                "projectId": self.project_id,
                                                "resourceContainer": "projects/%s" % (self.project_name),
                                                "timestamp": self.timestamp
                                               }
        evidence.append(evidence_sourcelogid)
        return evidence

    def jsonpayload_properties(self):
        properties = {}
        properties["loadBalancerName"] = "k8s2-um-e934oejq-rubrik-%s-hjfq2839" % self.project_name
        properties["refererUrl"] = self.referer_url
        properties["requestUrl"] = self.request_url
        properties["requestUserAgent"] = self.request_ua
        return properties

    def jsonpayload_sourceid(self):
        sourceid = {}
        sourceid["customerOrganizationNumber"] = self.org_id
        sourceid["projectNumber"] = self.project_id
        return sourceid

    def jsonize(self):
        del self.project_id
        del self.project_name
        del self.org
        del self.org_id
        del self.detector_name
        del self.findingcategory
        del self.utils
        del self.referer_url
        del self.request_url
        del self.request_ua
        
        return json.dumps(self.__dict__)

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        try:
            org = event["variables"]["$org"]
        except:
            org = "My Organization"
        try:
            rule_name = event["variables"]["$rule_name"]
        except:
            rule_name = "compromise_attempt"
        try:
            rule_desc = event["variables"]["$rule_desc"]
        except:
            rule_desc = "Initial access: Comprimise Attempt"
        try:
            referer = event["variables"]["$referer"]
        except:
            referer = ""
        try:
            uri = event["variables"]["$uri"]
        except:
            uri = "/"
        try:
            useragent = event["variables"]["$user-agent"]
        except:
            useragent = self.get_random_user_agent()
        
        notification = SCCNotification(self, org=org,detector_name=rule_name,findingcategory=rule_desc,referer_url=referer,request_url=uri,request_ua=useragent)
        notification_event = notification.jsonize()
        notification_event = frame_time.strftime(notification_event)
        notification_event += "\n"
        
#        print(str(notification_event))
        
        yield bytes(notification_event, "utf8")
