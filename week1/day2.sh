#!/bin/bash
# Day2: file permissions and user management

# FILE PERMISSIONS
# Every file in Linux has three permission groups: 
# 1. Owner (the user who created the file)
# 2. Group (users belonging to the file's group)
# 3. Others (everyone else)
# Each group gets three permissions: r (read), w (write), x (execute).
- rw- r-- r--
↑ ↑↑↑ ↑↑↑ ↑↑↑
│ │││ │││ └── Others: r-- = read only
│ │││ └────── Group: r-- = read only
│ └────────── Owner: rw- = read + write (no execute)
└──────────── File type: - = regular file, d = directory

# The Permission Number Table
Number	Permissions	What It Means
7	rwx	        Read + Write + Execute (full control)
6	rw-	        Read + Write (most common for owner)
5	r-x	        Read + Execute (common for directories)
4	r--	        Read only (config files visible to all)
3	-wx	        Write + Execute (rare)
2	-w-	        Write only (rare)
1	--x	        Execute only (rare)
0	---	        No permissions (shadow file for others)

# Common Permission Combinations
Numeric	Symbolic	Typical Use
755	rwxr-xr-x	Executable programs, directories
644	rw-r--r--	Regular files (/etc/passwd)
600	rw-------	SSH private keys, sensitive files
700	rwx------	Private scripts, personal directories
777	rwxrwxrwx	World-writable — DANGEROUS!
640	rw-r-----	Group-readable sensitive files
400	r--------	Read-only private files

# Syntax Examples
chmod 644 testfile
chmod 755 testfile
chmod 600 testfile

# chmod : Changing Permissions
# chmod with numbers: chmod [owner][group][others] file
# chmod +x <bf>.sh : Make a bash script executable 


# USER MANAGEMENT
# whoami : which user are you?
# id : full identity - uid, gid, and all group memberships
# who : who else is logged into this system right now?
# cat /etc/passwd : the user database
  Format: username:password:UID:GID:comment:home_dir:shell
# sudo : run ONE command as root, then return to normal user
# sudo -l : what can the current user run with sudo?
# sudo adduser <testuser> : Create a new user
# su - <testuser> : Switch to another user

# SUID Bit
The SUID (Set User ID) bit is a special permission that makes a file execute as its owner, not as the person running it. 
When a file is SUID and owned by root, it runs as root regardless of who executes it.
