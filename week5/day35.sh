#!/bin/bash

# MITRE ATT&CK NAVIGATOR
  The MITRE ATT&CK navigator (mitre-attack.github.io/attack-navigator/) is a web-based tool for visualising the ATT&CK matrix. (Build Attack Map)
# SEARCHSPLOIT : Finding Public Exploits for Discovered Services
  Searchsploit searches the ExploitDB database locally.
  ExploitDB = archive of public exploits, often used by attackers
1. After Nmap finds: Apache Tomcat 7.0.88 : 'searchsploit apache tomcat 7.0'
    Apache Tomcat 7.0.x - Manager Bypass | java/webapps/31433.txt
    Apache Tomcat < 9.0.1 - Remote Code | java/webapps/44394.py
2. Read an exploit without modifying it : 'searchsploit -x java/webapps/31433.txt'
3. Copy exploit to current directory to modify : 'searchsploit -m java/webapps/44394.py'
4. Search for SSH version exploits : 'searchsploit openssh 7.9'
5. Update the exploit database : 'searchsploit --update'
   'Workflow:' Nmap finds version -> searchsploit the version -> find relevant exploit -> read the exploit -> understand what it does -> adapt to your target
    Always read exploits before running them.
    Public exploits sometimes have backdoors or require modification for your specific target configuration.
