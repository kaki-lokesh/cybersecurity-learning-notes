#!/bin/bash

# SSH - SECURE SHELL 
  SSH is the standard protocol for securely accessing remote Linux systems.

# ssh-keygen -t ed25519 -C "your.email@example.com" : Generate an SSH key pair
1. Enter file in which to save the key (/home/user/.ssh/id_ed25519): [press Enter]
2. Enter passphrase (empty for no passphrase): [enter a passphrase for security]
3. Your identification has been saved in /home/user/.ssh/id_ed25519
4. Your public key has been saved in /home/user/.ssh/id_ed25519.pub

id_ed25519 = PRIVATE key — never share this with anyone, ever
id_ed25519.pub = PUBLIC key — share this with servers you want to access

# cat ~/.ssh/id_ed25519.pub : view your public key 
# Permission for SSH:
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_ed25519
  chmod 644 ~/.ssh/id_ed25519.pub
Important- password can be brute-forced, ed25519 key has 2^256 possible values

# COMPLETE /var/log ECOSYSTEM
"Log File"	             "What It Records"
/var/log/auth.log            ALL authentication: SSH logins, sudo commands, user switches
/var/log/syslog              General system messages from all services
/var/log/kern.log            Kernel messages: hardware events, driver errors
/var/log/apache2/access.log  Every HTTP request to the web server
/var/log/apache2/error.log   Apache errors: 404s, PHP errors, permission denied
/var/log/dpkg.log            Package installations and removals
/var/log/cron                Cron job executions
/var/log/lastlog             Last login for every user account
/var/log/wtmp                Login/logout history (binary — use 'last' to read)
/root/.bash_history          Commands typed by root (if not cleared)
/home/user/.bash_history     Commands typed by that user
