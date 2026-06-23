#!/bin/bash

# CVSS v3.1
  CVSS (Common Vulnerability Scoring System) v3.1 is the industry standard for rating the severity of security vulnerabilities.
  Every CVE in the National Vulnerability Database (NVD) has a CVSS score.
  Every professional pentest report uses CVSS to score findings.
  - Without CVSS, severity ratings are subjective - one consultant's "high" is another's "medium".
  - With CVSS, severity is calculated from objective criteria.
  The CVSS score is a number from 0.0 to 10.0, broken into categories: None (0.0), Low (0.1–3.9), Medium (4.0–6.9), High (7.0–8.9), Critical (9.0–10.0).
  The score is derived from three metric groups:
  - Base (the vulnerability itself)
  - Temporal (current exploit availability)
  - Environmental (your specific context)
# CVSS v3.1 Base Metrics
 Metric	                     Options	       Meaning in Plain English
"EXPLOITABILITY METRICS - How easy is it to exploit?"
1.Attack Vector (AV)	     Network-Adjacent  Where must the attacker be? Network = internet, Adjacent = same LAN,
                             -Local-Physical   Local = needs login first, Physical = must touch the device.
2.Attack Complexity (AC)     Low-High          Does the attacker need special conditions beyond their control?  Low = fire and forget.
                                               High = requires specific timing, race conditions, or external prerequisites.
3.Privileges Required (PR)   None-Low-High     What access does the attacker need before exploiting? None = no login needed.
                                               Low = regular user account. High = admin/privileged account.
4.User Interaction (UI)      None-Required     Does a victim need to do something (click a link, open a file)? None = fully automated.
                                               Required = victim must take action (e.g. XSS requires victim to visit the page).
5.Scope (S)                  Unchanged-Changed Does the exploit affect only the vulnerable component, or can it impact other systems?
                                               Changed = can jump security boundaries (e.g. VM escape, SSRF to internal network).
"IMPACT METRICS - What happens if exploited?"
1.Confidentiality Impact (C) None-Low-High     Can the attacker read data they shouldn't? None = no data exposed. Low = limited data.
                                               High = all data in scope exposed (e.g. full database dump).
2.Integrity Impact (I)	     None-Low-High     Can the attacker modify data or system state? High = can modify any data, install malware,
                                               change configurations.
3.Availability Impact (A)    None-Low-High     Can the attacker disrupt service? High = can take the service completely offline 
                                               (e.g. crash the server, consume all resources).
