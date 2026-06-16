#!/bin/bash

# SHODAN
  Shodan continuously scans the internet,
   Connects to services on every open port,
    Reads the service banners (what the server says when you connect),
     Indexes the information.
  Shodan query gives:
  - All devices running a specific software version
  - All devices in a country with a specific port open
  - All devices with a specific vulnerability in their banner
  For OSINT and threat intelligence:
   Shodan tells you exactly what services an IP address or organisation is exposing to the internet - without directly scanning them.
  For a defender, Shodan shows what attackers already know about your infrastructure.
# Shodan API
1. /shodan/host/{ip}   :  Full data for one IP address
2. /shodan/host/search : Search by query string
3. /shodan/ports       :  List of ports Shodan indexes
4. /dns/resolve        : Resolve hostname to IPs
5. /dns/reverse        : Reverse DNS lookup
# AbuseIPDB API
1. /check       : Check single IP for abuse reports
2. /report      : Submit an abuse report for an IP
3. /blacklist   : Get list of most reported IPs
4. /bulk-report : Submit multiple reports at once
