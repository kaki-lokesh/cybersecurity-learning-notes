#!/bin/bash

# CROSS-SITE SCRIPTING (XSS)
  'OWASP A03:2021 - INJECTION'
  An attacker injects malicious JavaScript into a web page that executes in the victim's browser in the context of the vulnerable website.
  XSS can steal session cookies, redirect users, capture keystrokes, deface pages and is the primary way to chain vulnerabilities together (XSS + CSRF, XSS + sessionhijacking).
  'There are THREE types:'
1. REFLECTED XSS
  Payload is the request (URL/POST), reflected in the response.
  Attacker sends link to victim containing XSS payload.
  Not stored - only fires when the victim clicks the link.
2. STORED XSS (Persistent)
  Payload is saved in the database and served to all future visitors.
  Attacker submits payload in a comment/post. Every user who visits the page executes the script.
  Much higher impact - no victim needs to click a special link.
3.DOM-BASED XSS
  Payload is processed by JavaScript in the browser, never sent to the server.
  Server response is always clean - the vulnerabilty is in client-side JavaScript code that uses URL hash (#) or localStorage unsafely.
# Real Impact of XSS
  Session hijacking:     Steal the PHPSESSID cookie -> login as victim. The #1 real-world XSS attack.
  Keylogger:             JavaScript that sends every keystroke to attacker's server. Captures passwords entered after the page loads.
  Phishing:              Replace the page content with a fake login form. Victim thinks they're on the real site.
  BeEF framework:        Real-world tool that hooks XSS victims and provides remote control of their browser
  Internal network scan: JavaScript can make requests to internal IPs from victim's browser - bypasses firewall
