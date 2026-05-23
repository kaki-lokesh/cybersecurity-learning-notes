#!/bin/bash

# ARP ADDRESS RESOLUTION PROTOCOL
  IP addresses identify hosts globally, but on a local network communication actually uses MAC addresses
  ARP is the protocol that translates IP addresses into MAC addresses on the local network.
  This concept is important for understanding man-in-the-middle attacks on local networks.
# Working of ARP
  PC wants to send a packet to 192.168.1.1 (my router), but Ethernet needs a MAC address, not an IP.
  So PC commands: ARP Request: "Who has 192.168.1.1? Tell 192.168.1.5 (my IP)"
  This is sent to MAC FF:FF:FF:FF:FF:FF (broadcast=everyone hears it)
  The router at 192.168.1.1 replies: ARP Reply: "192.168.1.1 is at AA:BB:CC:DD:EE:FF"
  PC caches this in its ARP table and sends the Ethernet frame 
# ARP Commands
1. arp -a: View your ARP table (cached IP-MAC mappings)
   ip neigh show: Modern ip command
# ARP Spoofing / ARP Poisoning
  critical security vulnerability: ARP has no authentication (Anyone on the local network can send a fake ARP reply)
  This is a Man-in-the-Middle (MITM) attack on local networks

# SUBNETTING
  Subnetting divides a large IP address space into smaller networks.
  The notation uses CIDR (Classless Inter-Domain Routing): 192.168.1.0/24 where /24 is the subnet mask
# CIDR Notation Table
'CIDR Subnet Mask	Hosts	   Example Use'
 /32  255.255.255.255	1	   Single host route
 /30  255.255.255.252	2	   Point-to-point links
 /29  255.255.255.248	6	   Small segment
 /28  255.255.255.240	14	   Small subnet
 /27  255.255.255.224	30	   Small office segment
 /24  255.255.255.0	254	   Typical home/office LAN
 /23  255.255.254.0	510	   Medium office
 /16  255.255.0.0	65,534	   Large organisation
 /8   255.0.0.0	        16,777,214 ISP block
 /0   0.0.0.0	        All IPs	   Default route (internet)
# Calculate subnet
  Example: 192.168.10.0/24
  Network Address: 192.168.10.0 (first address- identifies the subnet)
  Broadcast: 192.168.10.255 (last address- sends to all hosts)
  First Host: 192.168.10.1
  Last Host: 192.168.10.254
  Total hosts: 254 (256 - 2 for network+broadcast)
# Private IP Ranges
  10.0.0.0/8 : 10.0.0.0 to 10.255.255.255 (Class A private)
  172.16.0.0/12 : 172.16.0.0 to 172.31.255.255 (Class B private)
  192.168.0.0/16 : 192.168.0.0 to 192.168.255.255 (Class C private, your home network)
  127.0.0.0/8 : Loopback (127.0.0.1 = localhost, your own machine)
# Subnetting Commands
1. ip addr show : View your network interface info
2. ipcalc : subnet calculator (install: sudo apt install ipcalc)
   SYNTAX- ipcalc <IP with subnet mask>

# FIREWALL 
  A firewall examines network packets and decides whether to allow or block them based on rules.
# Firewall Types
1. Packet Filter (Layer 3/4): Checks IP header and TCP/UDP ports only. Rules like "allow TCP port 80 from any to web server"
                              Cannot inspect application data. Basic routers use this.

2. Stateful Firewall: Tracks connection state. Allows established TCP connections (ACK packets) but blocks new unsolicited connections (SYN packets from internet)
                      Most modern firewalls are stateful

3. Application Layer / NGFW: Inspects HTTP content, identifies applications, detects malware signatures.
                             Can block specific UPL's, file types, or application behaviours. Expensive but more secure.

4. WAF (Web Application Firewall): Specifically for HTTP/HTTPS traffic. Detects SQL injection, XSS, and other web attacks in HTTP requests.
                                   Often bypassed by encoding payloads differently.

# IPTABLES - LINUX FIREWALL
1. iptables -L -n -v : View current firewall rules
2. iptables -A INPUT -s 192.168.1.100 -j DROP : Block all traffic from a specific IP
3. iptables -A INPUT -p tcp --dport 22 -j ACCEPT : Allow incoming SSH only
4. iptables -A INPUT -j DROP : Block everything else
