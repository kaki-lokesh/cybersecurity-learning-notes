#!/bin/bash

# REGULAR EXPRESSION
  A regular expression (regex) is a pattern that matches text
  Threat analysts use regex to extract 'Indicators of Compromise' (IOCs) - IP addresses, domain names, file hashes, email addresses and malicious URLs

  # This concept is practiced in python file: regex_masterclass.py
# Core re functions
1. re.search(pattern, string) : first match anywhere in string (or None)
2. re.match(pattern, string) : match only at START of string
3. re.findall(pattern, string) : list of ALL matches
4. re.finditer(pattern, string) : iterator of match objects
5. re.sub(pattern, replacement, string) : replace matches
6. re.compile(pattern) : compile for repeated use (faster)
# Regex metacharacters
1. .  = any character except newline
2. *  = 0 or more of previous
3. +  = 1 or more of previous
4. ?  = 0 or 1 of previous
5. {n} = exactly n repetitions
6. {n,m} = between n and m repetitions
7. ^  = start of string/line
8. $  = end of string/line
9. [] = character class (any one char in brackets)
10. () = capture group
11. |  = OR
12. \d = digit [0-9]
13. \w = word character [a-z,A-Z,0-9,_]
14. \s = whitespace
15. \b = word boundary
16. \S = non-whitespace
