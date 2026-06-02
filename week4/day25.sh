#!/bin/bash

# CROSS-SITE REQUEST FORGERY (CSRF)
  CSRF tricks a victim's browser into making an authenticated request to a  target site without the victims knowledge or consent.
  The victim is logged into the target site. The attacker crafts a page that automatically sends a state-changing request:
  - password change
  - fund transfer
  - email change using the victims existing session.
  The target site can't distinguish the legitimate request from the forged one.
# Key Insight:
  browsers automatically include cookies with every request to a domain.
  If you're logged into bank.com and you visit attacker.com, attacker.com's JavaScript can make requests to bank.com that carry your bank.com session cookie.
# CSRF fix - ANTI-CSRF Tokens
  Secure applications add a random, unpredictable token to every state-changing request. The server validates this token.
  An attacker's forged request cannot include the correct token.

# INSECURE DIRECT OBJECT REFERENCE (IDOR)
  IDOR occurs when an application uses user-controllable input to access objects directly without verifying that the current user is authorised to access that specific object.
  It is one of the most commonly found and most commonly paid vulnerabilities in bug bounty programs.
  Example: my profile is at "?user_id=1234". Change 1234 to 1235. If I found another user's profile - that is an IDOR.
  "HOW TO FIND IDOR VULNERABILITIES"
  1. Look for IDs in URLs- /profile?id=123, /document?file=789
  2. Look for IDs in POST bodies- {"user_id": 274, "user_id":673}
  3. Look for IDs in cookies or headers

# AUTHENTICATION ATTACKS - Brute Force & Credential Stuffing
  'METHOD 1': Burp Suite Intruder (GUI)
  'METHOD 2': Hydra (command line, no rate limit)
  kali@kali:~$ hydra -l admin -P /usr/share/wordlists/rockyou.txt \
    127.0.0.1 http-post-form \
    "/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login and/or password incorrect.:H=Cookie: PHPSESSID=abc123; security=low"
# [80][http-post-form] host: 127.0.0.1 login: admin password: password
  FORMAT- "PATH:POST_BODY:FAILURE_STRING:HEADER"
  'FAILURE_STRING' must be text that must appear on failed login page anf if its wrong, Hydra reports everything as a success
# Username Emuneration
  "Unknown username" - user doesn't exist
  "Incorrect password" - user EXISTS (valid username)





















