#!/bin/bash

# TCP/IP 4-LAYER MODEL
  Data Encapsulation - The process of wrapping data in multiple layers of headers (like envelopes inside envelopes).
  Each layer adding information needed for next stage of delivery.
# Architecture of TCP/IP model
"Layer	Name	        What It Does	                                 Protocols"
 4	Application	User-facing protocols. Where apps communicate.	 HTTP, HTTPS, DNS, SMTP, FTP, SSH
 3	Transport	End-to-end delivery. Port numbers. Reliability.	 TCP, UDP
 2	Internet	Logical addressing. Routing between networks.    IP, ICMP, ARP
 1	Network Access	Physical transmission. MAC addressing.	         Ethernet, Wi-Fi, cables

# IP HEADER
  The IP header travels with every packet and contains routing information.
  Attackers manipulate IP headers for spoofing attacks.
  Analysts read IP headers to track attacker traffic.
" Field           VALUE RANGE                     SECURITY SIGNIFICANCE"
  TTL             1-255(Linux: 64, Windows: 128)  "key"OS fingerprinting-initial TTL reveals OS
  Protocol        1=ICMP, 6=TCP, 17=UDP           Firewalls filter based on protocol number
  Source IP       Any 32-bit address (4 bytes)    "key"Can be FORGED (IP Spoofing)
  Flags (DF Bit)  Don't Fragment                  MTU discovery
  Identification  16-bit counter                  Historically used for idle scanning

# WIRESHARK
  An application that helps capture real traffic and read actual IP headers.
# Step-by-Step First Capture
  STEP 1: Open Wireshark on Windows
  STEP 2: Double-click your active network adapter (Wi-Fi or Ethernet)
  STEP 3: Capture starts - you see packets flowing
  STEP 4: Generate http traffic - open browser -> go to
  STEP 5: In Wireshark filter bar, type "http"
  STEP 6: Click on an HTTP GET packet and expand to study the packet.
FORMAT-
 Internet Protocol Version 4, Src: YOUR-IP, Dst: SERVER-IP
 Version: 4
 Header Length: 20 bytes
 Total Length: 582
 Time to live: 128             <- you're on Windows, default TTL=128
 Protocol: TCP (6)
 Source Address: 192.168.x.x   <- your IP
 Destination Address: x.x.x.x  <- neverssl.com's IP

