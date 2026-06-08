#!/bin/bash

# PENTEST METHODOLOGY
# 5-PHASE PENTEST METHODOLOGY
  A penetration test is not a random attack.
  It follows a structured methodology that ensures
  - comprehensive coverage
  - maintains evidence for the report
  - avoids causing unintended damage
 'Phase 1  Reconnaissance'
    Passive + Active info gathering. OSINT, DNS, WHOIS, Shodan
 'Phase 2  Enumeration'
    Nmap, service probing, web dirs, user enum, version detection
 'Phase 3  Exploitation'
    Initial access using identified vulnerabilities. Shells, auth bypass
 'Phase 4  Post-Exploitation'
    Priv esc, persistence, lateral movement, data collection
 'Phase 5  Reporting'
    Document findings, risk ratings, evidence, remediation

# PHASE 1 - RECONNAISSANCE: PASSIVE & ACTIVE
  'Passive reconnaissance' gathers information without directly interacting with the target: using public resources like
  - WHOIS, DNS records, Google, LinkedIn, Shodan and certificate transparency logs
  The target cannot detect passive recon.
  'Active reconnaissance' interacts directly with the target:
  - Nmap scanning, service probing, directory brute-forcing
  The target can potentially detect and log this activity.
# Passive Recon
1. WHOIS : registration details, registrar, admin contact
    SYNTAX- whois targetdomain.com
2. DNS enumeration : find all subdomains and records
    SYNTAX- dig targetdomain.com ANY
    SYNTAX- dnsenum targetdomain.com
    SYNTAX- sublist3r -d targetdomain.com
     Finds: mail.target.com, vpn.target.com, dev.target.com, staging.target.com
3. theHarvester - emails, subdomains, IPs from public sources
    SYNTAX- theHarvester -d targetdomain.com -b google,bing,linkedin
     Emails found: admin@target.com, john.doe@target.com
     Hosts found: mail.target.com, www.target.com
4. Certificate Transparency Logs - find all issued SSL certs for a domain
    SYNTAX- crt.sh/?q=%.targetdomain.com
     Shows all subdomains that have had SSL certs issued - including internal ones
5. Shodan - find internet-exposed services for the target's IP range
    SYNTAX-  shodan search "org:TargetCompany"
     Reveals: open ports, running services, software versions
6. Google Dorks  find sensitive info indexed by Google
    site:target.com filetype:pdf       -> indexed PDFs (may contain sensitive info)
    site:target.com inurl:admin        -> admin panels
    site:target.com "index of"         -> directory listings
    site:target.com ext:bak OR ext:old -> backup files
    "target.com" filetype:sql          -> SQL dumps
# PHASE 2 - ENUMERATION: ACTIVE SERVICE DISCOVERY
  'Enumeration' directly probes the target to identify running services, software versions, users, shares, and configuration details.
  This is where you answer: "What is this target running and is it vulnerable?"
# Enumeration Toolkit
  STEP 1: Always start with Nmap (standard HTB/CTF initial scan)
   SYNTAX- nmap -sC -sV -oN initial.txt TARGET_IP
   FORMAT- PORT STATE SERVICE VERSION
   -sC = default scripts, -sV = version detection, -oN = save to file
  STEP 2: Full port scan to catch non-standard ports
   SYNTAX- nmap -p- --min-rate 5000 -oN allports.txt TARGET_IP
    Check: is there anything on port 3306 (MySQL)? 5985 (WinRM)? 6379 (Redis)?
 # HTTP Enumeration  when port 80 or 8080 is open
   SYNTAX- gobuster dir -u http://TARGET_IP -w /usr/share/seclists/Discovery/Web-Content/common.txt
    gobuster finds hidden directories by brute-forcing common names
 # SMB Enumeration (port 445 open)
   SYNTAX- smbclient -L //TARGET_IP -N
   SYNTAX- enum4linux -a TARGET_IP
    enum4linux: enumerates users, shares, groups, password policy from SMB/NetBIOS
 # SSH Enumeration (port 22 open)
   Check supported authentication methods:
   SYNTAX- ssh -v TARGET_IP 2>&1 | grep "Authentications"
    debug1: Authentications that can continue: publickey,password
    If 'password' is listed -> brute force may be possible
 # FTP Enumeration (port 21 open)
   SYNTAX- ftp TARGET_IP
    Try anonymous login: username 'anonymous', password: (empty or email)
    230 Login successful. <- Anonymous FTP enabled

# MITRE ATT&CK FRAMEWORK - THE LANGUAGE OF ATTACK INTELLIGENCE
  MITRE ATT&CK is a globally-accessible knowledge base of adversary tactics, techniques and procedures (TTPs) based on real-world observations.
  It is the standard framework used by threat intelligence teams, SOC analysts and security engineers to describe, detect and respond to attacks.
  Every technique used has a corresponding ATT&CK ID.
# Tactic TA0043 - Reconnaissance
  T1590 Gather Victim Network Info, T1589 Gather Victim Identity Info, T1596 Search Open Tech Databases (Shodan)
# Tactic TA0042 - Resource Development
  T1587 Develop Capabilities, T1588 Obtain Capabilities (tools, exploits)
# Tactic TA0001 - Initial Access
  T1190 Exploit Public-Facing App, T1566 Phishing, T1078 Valid Accounts
# Tactic TA0002 - Execution
  T1059 Command and Scripting Interpreter, T1053 Scheduled Task/Job, T1203 Exploitation for Client Execution
# Tactic TA0003 - Persistence
  T1546 Event Triggered Execution, T1053 Cron/Scheduled Tasks, T1543 Create/Modify Service
# Tactic TA0004 - Privilege Escalation
  T1068 Exploit Vulnerable Service, T1548 Abuse Elevation Control (SUID/sudo), T1055 Process Injection
# Tactic TA0005 - Defence Evasion
  T1070 Indicator Removal, T1027 Obfuscated Files, T1562 Impair Defences
# Tactic TA0006 - Credential Access
  T1110 Brute Force, T1003 OS Credential Dumping (Mimikatz), T1552 Unsecured Credentials
# Tactic TA0007 - Discovery
  T1082 System Info Discovery, T1083 File & Directory Discovery, T1046 Network Service Scan
# Tactic TA0008 - Lateral Movement
  T1021 Remote Services (SSH/RDP/SMB), T1550 Use Alternate Auth Material (Pass-the-Hash)
# Tactic TA0009 - Collection
  T1005 Data from Local System, T1113 Screen Capture, T1056 Input Capture (keylogger)
# Tactic TA0010 - Exfiltration
  T1041 Exfiltration Over C2 Channel, T1048 Exfil Over Alternative Protocol (DNS tunnelling)
