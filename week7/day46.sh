#!/bin/bash

# EXECUTIVE SUMMARY STRUCTURE
  The executive summary is written last - after you understand all findings.
  The key disciplines are:
  1. No acronyms without explanation:
      Do not write "SQLi" - write "SQL injection".
      Do not write "XSS" - write "cross-site scripting".
      Do not write "NT AUTHORITY\SYSTEM" - write "the highest Windows privilege level, equivalent to full administrative control."
  2. Lead with risk, not with findings:
      Do not start with "We found seven vulnerabilities", Start with "The assessed environment contains vulnerabilities that would allow an attacker to..." - the reader needs to understand the threat before they care about the technical details.
  3. One paragraph of business impact for every two findings:
      Do not list findings without explaining consequences. Executives make decisions based on consequences, not technical details.

  # PARAGRAPH 1: Context and scope (2-3 sentences)
    What was tested. When. What type of assessment. Who performed it.
    Do NOT start with "I performed..." - use third person or passive voice.
  # PARAGRAPH 2: Overall risk statement (2-3 sentences)
    High-level verdict on the security posture. How many critical/high/medium/low.
    One sentence on the most critical finding. One sentence on systemic issues observed.
  # PARAGRAPH 3: Key findings - top 2-3 only, in business language
    Not a full list - the summary table handles that. This highlights the most critical.
    Each finding gets one sentence: what it is, what it allows an attacker to do.
  # PARAGRAPH 4: Business impact (3-4 sentences)
    What could happen if these vulnerabilities were exploited in a real environment.
    Think: data breach, regulatory fines, service disruption, reputation damage.
    Do NOT speculate - only state impacts that your exploitation actually demonstrated.
  # PARAGRAPH 5: Recommended actions - top 3-5, prioritised
    Immediate actions (fix within 48-72 hours).
    Short-term actions (fix within the next sprint/week).
    Long-term actions (fix within next quarter - process improvements).
    Direct reader to Section 7 (Remediation Roadmap) for full details.
