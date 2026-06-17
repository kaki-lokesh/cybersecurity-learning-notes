#!/bin/bash

# VirusTotal API
1. ip_addresses/{ip} : IP reputation, detected URLs, communicating files
2. /domains/{domain} : Domain reputation, subdomains, resolutions
3. /files/{hash}     : File hash analysis, AV detections, malware family
4. /urls             : Submit URL for scanning (POST)
# WHOIS (python-whois)
  - Domain registration data - registrant, registrar
  - Creation, expiration, last update dates
  - Name servers (NS records)
  - Registration country and abuse contacts
