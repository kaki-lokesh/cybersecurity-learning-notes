#!/bin/bash

# NMAP NETWORK MAPPER
  Nmap sends crafted packets to target hosts and analyses the responses to determine:
  1. which hosts are alive
  2. which ports are open
  3. what services are running
  4. what OS is running
  5. what vulnerabilities may exist
  Nmap is the first tool in every penetration test engagaement and every CTF machine
# NMAP Scan Types
'Flag	Scan Type	      How It Works at Packet Level	                      When to Use'
 -sS	SYN Scan (Half-Open)  Sends SYN → if open: gets SYN-ACK → sends RST (no ACK)  Default scan. Most pentest engagements
                              Never completes handshake. fastest, most common scan    "Stealthy" on older systems
                              Requires sudo/root

 -sT    TCP Connect Scan      Does full 3-way handshake -> immediately closes         When you don't have root/sudo
                              connection. Logged by target.No raw sockets needed.     Slower, more detectable

 -sU    UDP Scan              Sends empty UDP packet -> closed port returns ICMP      Finding DNS (53), SNMP (161), DHCP (67/68)
                              Type 3 "port unreachable"                               Services missed by TCP scans
                              Open port: no response (or protocol specific response)

 -sV    Version Detection     Connects to open ports and sends protocol-specific      Always use with -sS
                              probes to read service banners                          Identifies software versions- search for CVEs

 -O     OS Detection          Analyses differences in TCP/IP stack implementation     Add to recon scans
                              Sends: TCP SYN to closed port, UDP to closed port,      Tells you if target is Linux, Windows, IoT device
                              ICMP timestamp request etc

 -A     Aggressive Scan       Combines: -O + -sV + --traceroute + -sC (very noisy)    CTF machines (noise doesn't matter)
                                                                                      Never in stealth pentests

 -p-    All Ports             Scans all 65535 TCP ports. Default scans only top       Thorough recon. Attackers often run services or
                              1000 most common.                                       non-standard ports to avoid default scans.

 -sC    Default Scripts       Runs Nmap Scripting Engine (NSE)
        (NSE)                 default scripts: banner grabbing, HTTP title, SMB info  Good default to add. Gives additional service info
                              SSL cert details.                                       without targeted attack scripts.

# NMAP Commands
Safe targets to scan: 127.0.0.1 (localhost)- always safe
                      scanme.nmap.org - Nmap's official test server
1. # nmap -sn 192.168.1.0/24 : Basic ping sweep - find alive hosts in a network range
2. # nmap -sS -p 1-1000 127.0.0.1 : SYN scan - most important, most common
   FORMAT- PORT STATE SERVICE
3. # nmap -sV -p 22,80,443 scanme.nmap.org : Version detection - reveals actual software
   FORMAT- PORT STATE SERVICE VERSION
4. # namp -O scanme.nmap.org : OS Detection (requires root, uses raw packets)
   FORMAT- Device type: general purpose
5. # nmap -sC -sV -oN initial.txt 10.10.10.95 : The HTB standard - what you run on every machine
   -sC = default scripts, -sV = versions, -oN = save output to file
   ALWAYS save nmap output: -oN (normal text), -oX (XML for parsing), -oA (all formats)
6. # nmap -p- --min-rate 5000 -sV 127.0.0.1 : Full port scan - find services on non-standard ports
   -p- = all 65535 ports. --min-rate 5000 = send at least 5000 packets/sec (faster)
7. # nmap --script=vuln 127.0.0.1 : NSE Vulnerability Scripts
8. Understanding POST STATES
   open = SYN-ACK received. Service is listening. Attack surface
   closed = RST received. Port is reachable but no service listening
   filtered = No response or ICMP unreachable. Firewall blocking

# IMPORTANT PORTS TO REMEMBER
  Remote Access: 22/tcp - SSH, 23/tcp - Telnet (insecure), 3389/tcp - RDP (Windows), 5900/tcp - VNC
  Web Services: 80/tcp - HTTP, 443/tcp - HTTPS, 8080/tcp - Alt HTTP, 8443/tcp - Alt HTTPS, 3000/tcp - Node.js dev
  File Services: 21/tcp - FTP, 20/tcp - FTP Data, 445/tcp - SMB, 139/tcp - NetBIOS, 2049/tcp - NFS
  Email: 25/tcp - SMTP, 587/tcp - SMTP TLS, 110/tcp - POP3, 143/tcp - IMAP, 993/tcp - IMAPS
  Databases: 3306/tcp - MySQL, 5432/tcp - PostgreSQL, 1433/tcp - MSSQL, 27017/tcp - MongoDB, 6379/tcp - Redis
  Network Services: 53/udp+tcp - DNS, 67-68/udp - DHCP, 161/udp - SNMP, 123/udp - NTP, 389/tcp - LDAP 

