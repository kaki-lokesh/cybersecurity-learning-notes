#!/bin/bash

# PROFESSIONAL PENTEST REPORT
  Three things separate a professional pentest report from a student write-up:
  - Audience Awareness (different sections speak to different readers)
  - Actionability (every finding tells the reader exactly what to do)
  - Evidence Integrity (every claim is supported by verifiable proof)
  A report that fails any of these three criteria is not usable.

# COMPLETE REPORT STRUCTURE (EXAMPLE)
  "Section 1  Cover Page and Document Metadata (1 page)"
  Engagement Title: Penetration Test Report - DVWA Web Application + HTB Jerry Windows Server
  Prepared by: Kaki Lokesh | Security Researcher
  Date: June 2026
  Classification: CONFIDENTIAL - For Authorised Recipients Only
  Version: 1.0 - Final
  Authorised Targets: DVWA Docker Container (localhost) | HTB Jerry (10.10.10.95) - HackTheBox Practice Environment
  Report Reference: PT-2026-001
  # The cover page establishes the legal and administrative context.


  "Section 2  Executive Summary (1-2 pages IMP)"
  Overview
  A penetration test was conducted against two authorised targets: the DVWA web application (simulating a typical PHP web application) and a Windows Server running Apache Tomcat (HTB Jerry).
  The assessment identified seven significant vulnerabilities, including two rated Critical severity and two rated High severity.

  Key Findings at a Glance
  The most critical finding was an unauthenticated SQL Injection vulnerability in the DVWA login page, which allowed complete extraction of all user credentials from the database without any prior authentication.
  A second Critical finding involved a default credential configuration on the Apache Tomcat Manager interface, which granted the ability to deploy arbitrary application code - resulting in complete operating system access with administrative privileges.

  Business Impact
  The vulnerabilities identified would allow a malicious actor with internet access to: gain access to all user accounts and stored data; execute arbitrary code on the server operating system; potentially pivot to other systems on the same network. 
  These outcomes represent significant risks to data confidentiality, system integrity, and service availability.

  Recommended Actions
  Three immediate actions are recommended:
  (1) Replace all string-concatenated database queries with parameterised statements - eliminates SQL injection as an attack class.
  (2) Change all service default credentials before deployment and implement a credential audit process.
  (3) Restrict the Tomcat Manager interface to localhost access only. Full remediation guidance is provided in Section 7.
  # The executive summary is written for the non-technical decision-maker (a CISO, a board member, a product manager).


  "Section 3  Scope and Rules of Engagement (1 page)"
  SCOPE STATEMENT
  In-Scope Systems:
  - DVWA Web Application - http://localhost (Docker container, local testing environment)
  - HTB Jerry - 10.10.10.95 (HackTheBox practice environment, explicitly authorised for testing)

  Out-of-Scope:
  - All other IP addresses and systems
  - Production systems, third-party services
  - Social engineering or physical security testing

  Testing Window: May 28-June 9, 2026
  Testing Type: Black-box web application assessment (DVWA); Black-box network/system assessment (HTB Jerry)
  Authorisation: DVWA is a self-hosted intentionally vulnerable application for education. HTB Jerry is part of the HackTheBox authorised practice platform.


  "Section 4  Methodology (1 page)"
  Testing Framework
  This assessment followed the PTES (Penetration Testing Execution Standard) methodology, supplemented by the OWASP Testing Guide v4.2 for web application components. 
  All identified vulnerabilities are classified according to the OWASP Top 10 (2021) and scored using CVSS v3.1.

  Phases Conducted
  Phase 1 - Reconnaissance: Passive information gathering via DNS enumeration, WHOIS, and service banner analysis. Active port and service scanning using Nmap (TCP SYN scan, version detection, default scripts).
  Phase 2 - Enumeration: Web directory discovery (Gobuster), manual application exploration, authentication mechanism analysis, input field identification.
  Phase 3 - Exploitation: Manual testing of identified vulnerability classes following OWASP Top 10 testing procedures. Authenticated and unauthenticated testing scenarios.
  Phase 4 - Post-Exploitation: System information gathering, privilege verification, flag capture (HTB environment).
  Phase 5 - Reporting: Finding documentation, CVSS scoring, remediation development.

  Tools Used: Nmap 7.93, Burp Suite Community, Gobuster 3.5, sqlmap 1.7, msfvenom (Metasploit Framework 6.3), Wireshark 4.0


  "Section 5  Risk Rating Summary (1 page)"
  +=================================================================================================+
  |#	 |  Finding                                    | Target    | CVSS Score | Severity | Status |
  |=================================================================================================|
  |F-001 | SQL Injection - Login Authentication Bypass | DVWA  	   | 9.8	| Critical | Open   |
  |F-002 | Default Credentials - Tomcat Manager	       | HTB Jerry | 9.8        | Critical | Open   |
  |F-003 | Stored Cross-Site Scripting (XSS)	       | DVWA	   | 8.8        | High	   | Open   |
  |F-004 | Command Injection - OS Command Execution    | DVWA	   | 8.8        | High	   | Open   |
  |F-005 | Unrestricted File Upload - PHP Webshell     | DVWA	   | 8.8        | High	   | Open   |
  |F-006 | Cross-Site Request Forgery (CSRF)	       | DVWA	   | 6.5        | Medium   | Open   |
  |F-007 | Overprivileged Application Process	       | HTB Jerry | 6.5        | Medium   | Open   |
  +=================================================================================================+
  # This summary table gives management a quick view of the attack surface.
