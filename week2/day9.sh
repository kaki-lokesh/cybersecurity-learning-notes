#!/bin/bash

# TCP TRANSMISSION CONTROL PROTOCOL
  TCP provides guaranteed, ordered delivery.
  If a packet is lost, TCP detects it and retransmits it.
  It does this by establishing a connection first (3-way handshake), tracking sequence numbers, and requiring acknowledgements for every segment.
# TCP Header Structure (20 bytes minimum)
LEVEL1:   Source Port — 16 bits         Destination Port — 16 bits
LEVEL2:  Sequence Number — 32 bits (tracks position in byte stream)
           Acknowledgement Number — 32 bits (next expected byte)
LEVEL3:   Data   Reserved  'FLAGS: URG ACK PSH RST SYN FIN'   Window Size
         Offset            The most security-relevant field  (flow control)

# TCP FLAGS & USES
1. SYN (Synchronize) - Opens a connection
2. ACK (Acknowledge) - Confirms receipt of data
3. FIN (Finish)      - Gracefully closes a connection
4. RST (Reset)       - Abruptly terminates connection
5. PSH (Push)        - Tells receiver to deliver data to app immediately without buffering
6. URG (Urgent)      - Urgent data pointer

# TCP 3-WAY HANDSHAKE
  Before any data is exchanged over TCP, both sides must establish a connection. This takes three packets. 
  Understanding this is critical because every TCP-based attack either exploits, mimics, or bypasses this handshake.
  3-Packets Sequence:
  Packet 1: YOUR-IP → SERVER-IP [SYN] Seq=0 Len=0
  Packet 2: SERVER-IP → YOUR-IP [SYN, ACK] Seq=0 Ack=1 Len=0
  Packet 3: YOUR-IP → SERVER-IP [ACK] Seq=1 Ack=1 Len=0
# Architecture
          'CLIENT'                       'SERVER'
        Your browser                    google.com
1.           *------------------------>SYN seq=1000
2. SYN-ACK seq=5000 ack=1001<----------------*
3.           *------------------------>ACK ack=5001
4.           *------------------------>Data flows → GET /

# UDP USER DATAGRAM PROTOCOL
  The UDP sends data without establishing a connection first.
  There is no handshake, no sequence numbers, no acknowledgements, no retransmission.
# UDP Header Architecture (8 bytes)
  ----------------------------------
  | Source Port | Destination Port |
  |   16 bits   |     16 bits      |
  ----------------------------------
  |   Length    |     Checksum     |
  |   16 bits   |     16 bits      |
  ----------------------------------
  |       Data (payload)           |
  ----------------------------------

# TCP vs UDP Protocols
        'Uses'                                      'Why'
  TCP   HTTP, HTTPS, SSH, FTP, SMTP                 Data Integrity critical
  UDP   DNS, DHCP, NTP, video stream, VoIP, gaming  Speed critical

# ICMP INTERNET CONTROL MESSAGE PROTOCOL ('Network Diagnostic Protocol')
  ICMP carries control messages and error reports between network devices.
  It's not a transport protocol - no data sending over ICMP. It reports on the network itself.
  The ping and traceroute tools are built entirely on ICMP.
