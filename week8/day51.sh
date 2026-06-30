#!/bin/bash

# DEVSECOPS
  DevSecOps means "Development, Security, and Operations" - integrating security checks automatically into every stage of the software development lifecycle.
  Instead of security being a separate review at the end (which finds issues too late), DevSecOps runs security tools automatically every time code is pushed.
  If a developer introduces a vulnerability, the pipeline catches it before it reaches production.
  The pipeline you will build this week does exactly what companies like Razorpay, CRED, and Zepto have in their development workflows.

# GITHUB ACTIONS
  GitHub Actions is a CI/CD platform built into GitHub.
  Every time you push codcme, it automatically runs a workflow defined in a YAML file.
  The workflow can run any commands - including security scanning tools.

# SECURITY SCANNING TOOLS
1. Bandit - Python SAST
   Static Application Security Testing for Python code.
   Reads your source code without running it and identifies security issues:
   - hardcoded passwords
   - use of insecure functions (eval, subprocess with shell=True)
   - weak crypto
   - SQL injection patterns and more.
   [+] bandit -r . -ll -ii -> Scan everything, report medium+ severity
       -ll = minimum medium severity
       -ii = minimum medium confidence
2. Safety - Dependency Scanning
   Checks every package in your requirements.txt against a database of known vulnerabilities.
   If you use Flask 0.12 (which has CVE-2019-1010083), Safety fails and tells you to upgrade.
   Prevents the "vulnerable library" supply chain attack.
   [+] safety check -r requirements.txt
3. Trivy - Container + IaC Scanning
   Scans Docker images for CVEs in the OS packages and application dependencies.
   Also scans Infrastructure as Code (Terraform, Kubernetes YAML) for misconfigurations.
   The most comprehensive open-source container security scanner.
   [+] trivy image myapp:1.0
