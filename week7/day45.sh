#!/bin/bash

# Anatomy of a Professional Finding
  Every finding in a professional pentest report follows the same template.
  This consistency matters because clients often re-use pentest reports for compliance audits, insurance requirements, and board presentations. Inconsistent formatting makes that impossible.
# Example Template (Standard)
  F-001  SQL Injection - Login Authentication Bypass    9.8 Critical
  [+] Severity - Critical
  [+] CVSS Score - 9.8
  [+] Target - DVWA Application
  [+] OWASP Category - A03:2021 - Injection
# FINDING WRITING
  "What Good Findings Look Like"
  Description: Explains root cause (why the vulnerability exists), not just the symptom
  Evidence:    Numbered reproduction steps anyone can follow, with screenshot references at each key step
  Impact:      Business language - "access to all customer records" not "C:H/I:H" without context
  Remediation: Specific, tested code examples - not "validate input"
  References:  Links to authoritative sources (CWE, OWASP, CVE database)
  Tone:        Objective and professional - no drama, no blame, no "this is terrible"
  Length:      Long enough to be complete, short enough to be readable - usually 400–700 words per finding

  "What Bad Findings Look Like"
  Too vague - no actionable information:
    SQL injection was found. It is bad because attackers can get the data. The fix is to sanitise inputs.
  Jargon without explanation:
    UNION-based blind in-band SQLi exfiltrated the schema via information_schema with SUBSTRING() boolean inferencing.
  No evidence:
    We found SQL injection and extracted the database. Screenshots are attached. (No screenshots attached, no reproduction steps)
  Remediation too generic:
    The developer should use secure coding practices and validate all inputs.

