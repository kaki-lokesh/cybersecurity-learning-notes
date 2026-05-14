#!/bin/bash

# TEXT PROCESSING
# GREP — Search for Patterns in Text
  grep stands for Global Regular Expression Print. It searches through text for lines matching a pattern.
# grep "Failed" ~/practice/auth.log : (Basic grep) find all lines containing the word "Failed"
# Conditions:
  Syntax : grep <cond> <find> ~/auth.log(file address)
# -i : case insensitive (matches "failed", "FAILED", "Failed")
# -c : count matching lines (displays count)
# -v : invert match (show lines that do NOT match)
# -n : show line numbers
# -r : recursive (search all files in a directory)
# -E : Multiple patterns; EX- grep -E "Failed|Invalid|error" ~/auth.log

# AWK — The Column Extractor and Data Processor
  awk treats each line of text as a series of fields separated by whitespace (or a custom delimiter).
  EX- May 1 09:15:32 ubuntu sshd[1234]: Failed password for root from 192.168.1.100 port 54321 
      $1    $2       $3     $4   $5     $6     $7       $8   $9  $10  $11              $12
# Extract ONLY the IP addresses from failed login lines
  grep "Failed password" ~/practice/auth.log | awk '{print $11}'
# Extract the username that was attempted (field 9 in "Failed password for USERNAME")
  grep "Failed password" ~/practice/auth.log | awk '{print $9}'
# Custom delimiter with -F (useful for /etc/passwd which uses :)
  awk -F: '{print $1, $3, $7}' /etc/passwd
  FORMAT - username uid shell

# SORT + UNIQ — Count and Rank
  After extracting data with grep and awk, sort orders the results and uniq -c counts duplicates. 
  This combination is how you find which IP attacked most frequently.
# The Complete Log Analysis Pipeline
Step 1: Get all failed login lines "grep "Failed password" ~/practice/auth.log"
Step 2: Extract just the IP addresses "grep "Failed password" ~/practice/auth.log | awk '{print $11}'"
Step 3: Sort them (uniq needs sorted input) "grep "Failed password" ~/practice/auth.log | awk '{print $11}' | sort"
Step 4: Count duplicates with uniq -c "grep "Failed password" ~/practice/auth.log | awk '{print $11}' | sort | uniq -c"
Step 5: Sort by count descending (most attacks first) "grep "Failed password" ~/practice/auth.log | awk '{print $11}' | sort | uniq -c | sort -rn"
# Find top attacked usernames : Just change 11 -> 9 in awk command
# {cut} cut -d: -f1 /etc/passwd  : alternative to awk for simple field extraction
  -d: = delimiter is colon -f1 = field 1 (first field)
# {sed} echo "Failed password for root" | sed 's/root/administrator/'  : Stream EDitor - find and replace in text
# sed 's/find/replace/g' : g = global, replace ALL occurrences
  EX- sed 's/192.168.1.100/[REDACTED]/g' ~/practice/auth.log > redacted.log
