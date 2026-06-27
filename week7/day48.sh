#!/bin/bash

# REPORT REVIEW
  Before any pentest report leaves a professional consulting firm, a senior consultant reviews it against a checklist.
  This review catches errors that damage client trust and the firm's reputation.
"Document Structure Checklist"
1.  Cover page includes: report title, date, author, classification, version, authorised targets
2.  Executive summary is readable without technical background - verified by read-aloud test
3.  Executive summary does not contain undefined acronyms (SQLi, XSS, CSRF must be spelled out first use)
4.  Scope clearly lists what was tested and explicitly what was NOT tested
5.  Methodology section names the frameworks used (PTES, OWASP Testing Guide)
6.  Risk rating summary table matches exactly the findings in Section 6 - no missing or extra entries
7.  All finding numbers (F-001 through F-007) appear consistently throughout the document
8.  Remediation roadmap includes priority, owner role, estimated effort, and suggested timeline for every finding
9.  All appendix items referenced in findings sections actually exist in appendices
10. Document version number and date are on every page footer (or at least the cover)

"Finding Quality Checklist"
1.  Description explains WHY the vulnerability exists (root cause), not just what it is
2.  Evidence section contains numbered reproduction steps that anyone can follow
3.  Evidence references actual screenshots by filename
4.  At least two screenshots per finding (vulnerability present + exploitation result)
5.  Impact section is written for a non-technical reader - business consequences, not attack descriptions
6.  Remediation includes specific code examples or configuration changes - not generic advice
7.  Remediation is broken into immediate, short-term, and long-term actions where applicable
8.  CVSS score matches the vector string - verified using the NVD calculator
9.  OWASP Top 10 category is correctly mapped (A01, A02, A03, etc.) and the year (2021) is specified
10. References section includes at least one authoritative link (OWASP, CWE, NVD)

"Screenshot Evidence"
1.  Cropped to show only the relevant content - usually 400–800 pixels wide
2.  The vulnerable input or injected payload is highlighted (red box or arrow)
3.  The evidence of exploitation is highlighted (successful bypass, extracted data)
4.  Caption underneath: "Figure 3: UNION attack extracting usernames and password hashes from the users table"
5.  All timestamps visible in the screenshot are consistent with the engagement window
6.  Burp Suite screenshots show both request and response panels, with key parts annotated
