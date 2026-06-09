#!/bin/bash

# BURP SUITE ADVANCED
  Burp Suite in week4 if for basic interception and manual modification.
  Burp Suite Advanced deepens Burp proficiency across all four primary tools:
  - Proxy
  - Repeater
  - Intruder
  - Decoder
# REPEATER
 "Purpose: Send a request, modify it, resend it, analyse the response"
  Use case: Testing SQLi payloads - send payload, check response, refine, repeat
  Workflow: Intercept request -> Right-click -> Send to Repeater -> Ctrl+R to switch
  Pro tip: Press Ctrl+Space to autocomplete parameter names in the request
  Pro tip: Right-click response -> Show response in browser -> renders the HTML result
# INTRUDER
 "Purpose: Automated payload injection - brute force, fuzzing, enumeration"
  Attack Types:
   Sniper -> One payload position, one payload list. Most common.
   Battering -> Multiple positions, same payload list. All permutations.
   Pitchfork -> Multiple positions, different payload lists (one list per position).
  Use case: username + password lists simultaneously
   Cluster -> Multiple positions, one list, all combos tested
   Pitchfork example: credential stuffing with usernames + passwords
    Position 1 (username): [admin, user, guest, root]
    Position 2 (password): [password, admin, 123456, letmein]
    Pitchfork tries: admin:password, user:admin, guest:123456, root:letmein
    first of list 1 with first of list 2
# DECODER
 "Encodes/decodes: URL, HTML, Base64, Hex, ASCII, gzip"
  Use case 1: XSS bypass - encode payload in HTML entities to evade filters
   <script> -> <script> -> HTML entity bypass
  Use case 2: Decode a Base64 session token to see its structure
   eyJhbGciOiJIUzI1NiJ9... -> {"alg":"HS256","typ":"JWT"} (JWT token)
  Use case 3: URL encode a payload for submission in URL parameters
   ' OR '1'='1 -> %27+OR+%271%27%3D%271

# TARGET -> SITE MAP
  Target -> Site Map shows all pages/requests Burp has seen for the target
   Browse the app with Burp running -> Site Map populates automatically
   Right-click any request -> Send to Repeater for testing
   This is how real pentesters map an application's attack surface

# ESSENTIAL SHORTCUTS
  Ctrl+I : Send to Intruder
  Ctrl+R : Send to Repeater
  Ctrl+G : Send request in Repeater
  F12    : Toggle Intercept on/off
  Ctrl+Z : Undo changes in request editor
