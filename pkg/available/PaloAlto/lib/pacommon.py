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

        # If unknown, return the most likely possiblity
    return "web-browsing"
