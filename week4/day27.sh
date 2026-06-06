#!/bin/bash

# SERVER-SIDE REQUEST FORGERY (SSRF)
  SSRF occurs when an attacker can make the server send HTTP  requests on their behalf.
  The attacker controls where the server sends requests - to internal services behind a firewall, to cloud metadata endpoints, or to external devices.
  This is one of the most impactful modern vulnerabilities because it bypasses network perimeter security.
  EXAMPLE- An application has a feature to fetch a URL and display the content - for importing data from external sites.
           An  attacker submits an internal URL like 'http://169.254.169.254/latest/meta-data/' (the AWS metadata endpoint).
           The server fetches it from inside the VPC and returns AWS credentials to the attacker.
# SSRF vectors - how attackers trigger it:
1. URL fetch features: "Enter a URL to import data from"
2. Webhook configurations: "Enter the callback URL for our webhook"
3. PDF generators: "Enter URL of page to convert to PDF"
4. Image proxy: "Enter image URL to display in your profile"
# Basic SSRF: Target points to localhost internal services
Attacker input: http://127.0.0.1/admin
Server fetches its OWN admin panel and returns it to attacker
The admin panel may only be accessible from localhost
# Cloud SSRF: AWS EC2 metadata endpoint (most critical)
Attacker input: http://169.254.169.254/latest/meta-data/
Returns: ami-id, instance-id, security-groups, iam/security-credentials
http://169.254.169.254/latest/meta-data/iam/security-credentials/role-name
Returns: AWS access key, secret key, session token -> full AWS account access

# SECURITY MISCONFIGURATION
  Security misconfiguration is the most commonly found vulnerability class in real-world assessments.
  Not a coding bug - a configuration oversight.
  - Default credentials left unchanged
  - Verbose error messagesexposing stack traces
  - Directory listing enabled
  - Unnecessary services running
  - Missing security headers

# CAPTURE THE FLAG (CTF)
  CTF (Capture The Flag) challenges are puzzle-style security challenges where we find a hidden "flag" string by exploiting a vulnerability.
  These train exactly the same skills as real-world testing:
  -reconnaissance
  -lateral thinking
  -technical exploitation
