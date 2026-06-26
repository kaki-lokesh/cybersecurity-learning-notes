#!/bin/bash

# REMEDIATION ROADMAP
  The remediation roadmap translates your findings into a prioritised action plan for the development and operations team.
  It answers: "If I have to fix everything, what do I fix first?"
  Priority is based on severity (CVSS score) modified by exploitation ease and business impact.
'Priority         Finding                       Owner        Effort  Timeline CVSS'
 P1 - Immediate   F-001: SQL Injection          Backend Dev  Hours   24 hours 9.8
 P1 - Immediate   F-002: Default Credentials    DevOps/Ops   Minutes Same day 9.8
 P2 - This Sprint F-005: File Upload            Backend Dev  Days    1 week   8.8
 P2 - This Sprint F-004: Command Injection      Backend Dev  Hours   1 week   8.8
 P2 - This Sprint F-003: Stored XSS             Frontend Dev Days    1 week   8.8
 P3 - Next Sprint F-006: CSRF                   Backend Dev  Days    2 weeks  6.5
 P3 - Next Sprint F-007: Overprivileged Process DevOps/Ops   Hours   2 weeks  6.5

# APPENDICES
  Appendices contain detailed technical information that would interrupt the flow of the main report if included inline.
  They are referenced from the findings sections.
  Common appendices include:
  - Full Nmap output
  - Burp Suite request/response pairs
  - Tool version information
  - Methodology references
