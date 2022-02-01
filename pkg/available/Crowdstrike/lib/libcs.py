import random

def build_pid_variables(libcontext, event):
    first_pid = random.randint(10000000000000,99000000000000)
    if "$ParentProcessId" not in event["variables"]:
        event["variables"]["$ParentProcessId"] = str(first_pid)
    if "$SourceProcessId" not in event["variables"]:
        event["variables"]["$SourceProcessId"] = event["variables"]["$ParentProcessId"]
    if "$SessionProcessId" not in event["variables"]:
        event["variables"]["$SessionProcessId"] = str(first_pid + random.randint(10, 300))
    if "$ProcessGroupId" not in event["variables"]:
        event["variables"]["$ProcessGroupId"] = str(first_pid + random.randint(300, 10000))
    if "$TargetProcessId" not in event["variables"]:
        event["variables"]["$TargetProcessId"] = str(first_pid + random.randint(5000, 30000))
    if "$RawProcessId" not in event["variables"]:
        event["variables"]["$RawProcessId"] = str(random.randint(1000, 50000))
    
    return event
    
def build_variables(libcontext, event):
    if "$aid" not in event["variables"]:
        event["variables"]["$aid"] = libcontext.gen_uuid_fixed(event, event["variables"]["$aip"]).replace("-", "")
    if "$id" not in event["variables"]:
            event["variables"]["$id"] = libcontext.gen_uuid(event)
    if "$MD5HashData" not in event["variables"]:
        event["variables"]["$MD5HashData"] = libcontext.gen_md5()
    if "$SHA256HashData" not in event["variables"]:
        event["variables"]["$SHA256HashData"] = libcontext.gen_sha256()
    if "$ConfigStateHash" not in event["variables"]:        
        event["variables"]["$ConfigStateHash"] = random.randint(1000000000, 9000000000)
    
    return event
