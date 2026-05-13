#!/bin/bash
# PROCESS MANAGEMENT
  Every program running on a Linux system is a process with a unique PID (Process ID). 
  During incident response, analysts check running processes for malware.
  During privilege escalation, attackers look for processes running as root that they can abuse.

# ps : snapshot of current processes
FORMAT = PID TTY TIME CMD
# ps aux : ALL processes on the system
FORMAT = USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
During incident response — look for: unusual process names, high CPU/RAM
# cat /proc/PID/cmdline : exact command that started any process
# kill <PID> : terminate a process by PID
Signal 15 (default) = polite "please stop" → process can ignore
# kill -9 <PID> : FORCE kill, process cannot ignore this signal
Signal 9 = "stop immediately" → cannot be ignored


# NETWORK STATUS COMMANDS
  During incident response, after checking running processes, analysts check network connections. 
  An attacker maintaining access will have a connection back to their server (a reverse shell or C2 beacon). 
  These commands reveal every open connection and listening port.

# ss -tulnp : Socket Statistics (modern replacement for netstat)
  -t = TCP, -u = UDP, -l = listening, -n = no DNS resolve, -p = show process
FORMAT = Netid State Local Address:Port Peer Address:Port Process
# ss -tnp state established : See all ESTABLISHED (active) connections
FORMAT = Recv-Q Send-Q Local Address:Port Peer Address:Port Process
# sudo lsof -i : List Open Files network connections
FORMAT = COMMAND PID USER FD TYPE DEVICE SIZE NODE NAME
# ip route : Check the routing table
