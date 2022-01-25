import random

def build_pid_variables(libcontext, event):
    first_pid = random.randint(10000000000000,99000000000000)
    event["variables"]["$ParentProcessId"] = str(first_pid)
    event["variables"]["$SourceProcessId"] = str(first_pid)
    event["variables"]["$SessionProcessId"] = str(first_pid + random.randint(10, 300))
    event["variables"]["$ProcessGroupId"] = str(first_pid + random.randint(300, 10000))
    event["variables"]["$TargetProcessId"] = str(first_pid + random.randint(5000, 30000))

    return event
    
def build_variables(libcontext, event):
    event["variables"]["$aid"] = libcontext.gen_uuid_fixed(event, event["variables"]["$aip"]).replace("-", "")
    event["variables"]["$id"] = libcontext.gen_uuid(event)
    event["variables"]["$MD5HashData"] = libcontext.gen_md5()
    event["variables"]["$SHA256HashData"] = libcontext.gen_sha256()
    event["variables"]["$ConfigStateHash"] = random.randint(1000000000, 9000000000)
    
    return event
