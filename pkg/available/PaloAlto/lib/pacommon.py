def guess_application(event):
    # We will need to parse appidize standard_ports and check the domain to map more applications
    if event["variables"]["$Protocol"] == "udp":
        if event["variables"]["$Destination Port"] == "53" or event["variables"]["$Source Port"] == "53":
            return "dns"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "80" or event["variables"]["$Source Port"] == "80":
            return "web-browsing"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "443" or event["variables"]["$Source Port"] == "443":
            return "web-browsing"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "445" or event["variables"]["$Source Port"] == "445":
            return "smb"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "22" or event["variables"]["$Source Port"] == "22":
            return "ssh"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "3389" or event["variables"]["$Source Port"] == "3389":
            return "ms-rdp"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "21" or event["variables"]["$Source Port"] == "21":
            return "ftp"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "23" or event["variables"]["$Source Port"] == "23":
            return "telnet"

    if event["variables"]["$Protocol"] == "tcp":
        if event["variables"]["$Destination Port"] == "3306" or event["variables"]["$Source Port"] == "3306":
            return "mysql"

        # If unknown, return the most likely possiblity
    return "web-browsing"
