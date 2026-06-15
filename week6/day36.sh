#!/bin/bash

# OSINT
  Open Source Intelligence (OSINT) is the collection and analysis of information from publicly available resources.
  In security, OSINT serves two roles:
   Offensive - Attackers use it to reconnoitre targets before an attack.
   Defensive - Defenders use it to understand what attackers know about their organisation, track threat actors and enrich security alerts with context.
  The critical principle is that 'OSINT uses only publicly available information - no hacking, no unauthorised access. Everything collected is already publicly accessible.'
  The skill is knowing where to look and how to correlate findings.
# Workflow
  Planning      : Define what you need to know. Scope your target
  Collection    : Gather data from public sources: DNS, WHOIS, Shodan, social
  Processing    : Clean, normalise, deduplicate raw data into usable format
  Analysis      : Correlate signals, identify patterns, assess risk, draw conclusions
  Dissemination : Report findings in format the consumer can act on
  Feedback      : Consumer validates and refines the intelligence cycle
# OSINT Sources
  Every OSINT investigation draws from multiple source categories.
  knowing which source to use for which question determines the quality of your intelligence.
# Network and Infrastructure Intelligence
  1. WHOIS records: Domain registrant, registration date, registrar, name servers. API: python-whois library
  2. DNS records: A, AAAA, MX, NS, TXT, CNAME. Tools: dig, dnspython library
  3. Certificate Transparency: All SSL certs ever issued for a domain - reveals subdomains. Site: crt.sh
  4. IP geolocation: Country, city, ASN, ISP. APIs: ipinfo.io, ip-api.com
  5. BGP/ASN data: Autonomous System Number - identifies the network block owner. Site: bgpview.io
  6. Reverse DNS: PTR records map IP to hostname. Tool: dig -x IP
  7. Shodan: Search engine for internet-connected devices. Queries services by banner, software, vulnerability
# Threat Intelligence and Reputation Sources
  1. VirusTotal: IP/URL/hash reputation. 70+ antivirus engines, community comments, related samples
  2. AbuseIPDB: Community-reported IP abuse. Categories: spam, brute force, port scan, DDoS
  3. AlienVault OTX: Open Threat Exchange - threat indicators shared by the community
  4. URLhaus: Malicious URL database - actively spreading malware
  5. Threat Intelligence feeds: MISP, STIX/TAXII format - shared between organisations
  6. Passive DNS: Historical DNS data - what IPs did this domain point to previously? Site: PassiveDNS
  7. CIRCL HASHLOOKUP: File hash to known malware family - fast classification
# INDICATORS OF COMPROMISE (IOCs)
  An Indicator of Compromise is a piece of forensic evidence that suggests a system may have been compromised or is associated with malicious activity.
  IOCs are the inputs and outputs of threat intelligence work.
'IOC Type      Example	                    Enrichment Source	            What Enrichment Tells You'
 IPv4 Address   185.220.101.1	            Shodan, AbuseIPDB, ipinfo       Services running, abuse history, geolocation, ASN - is this a Tor exit node? A known scanner?
 Domain Name    evil-c2.ru	            WHOIS, VirusTotal, DNS history  Registration date, registrar, whether other AV engines flagged it, historical IPs it resolved to
 URL	        http://evil.ru/payload.exe  VirusTotal, URLhaus	            Is it currently malicious? What malware family does it serve? When was it first seen?
 File Hash      d41d8cd98...e427e	    VirusTotal, MalwareBazaar	    Which AV engines detect it, malware family name, first seen date, related samples
  (MD5/SHA256)
 Email Address  attacker@evil.org	    HaveIBeenPwned, Hunter.io	    Has this email appeared in data breaches? Is it associated with domain registration?
 CVE ID	        CVE-2021-44228	            NVD, CIRCL, Shodan CVE search   CVSS score, affected software, patch status, how many exposed instances Shodan can see
