#!/bin/bash

# REQUESTS LIBRARY
  The requests library helps sending HTTP requests from Python with one line of code.   
  Compared to Python's built-in urllib, requests is dramatically simpler and more powerful.
  It handles cookies, sessions, authentication, redirects, timeouts and SSL automatically.
  It is the de-facto standard for HTTP in Python.
# requests Library Commands (py commands)
1. pip install requests : Install requests (if not done)
   python3 : Open Python shell
   import requests : Import requests library for use
2. r = requests.get('https://httpbin.org/get') : Simplest HTTP GET request
   # httpbin.org is a free HTTP testing service - returns what youu sent
3. r.status_code : Response object 'r' contains everything
   # 200=OK, 404=Not Found, 403=Forbidden, 500=Server Error
4. r.headers : Response headers - Content-Type tells you what format the body is in
   FORMAT- {'Content-Type': 'application/json', 'Server': 'gunicorn/19.9.0', ...}
5. r.text : Response body as a string
   FORMAT- '{\n "args": {},\n "headers": {\n "Host": "httpbin.org",\n ...\n}'
6. r.json() : Response body parsed as Python dictionary
   FORMAT- {'args': {}, 'headers': {'Host': 'httpbin.org', 'User-Agent': 'python-requests/2.31.0'}, ...}
7. r.url : Send HTTP request using url (Ex- 'https://httpbin.org/get')
8. r.elapsed : calculates how long the request took

# GET Parameters, Custom Headers & User-Agent Spoofing
  URL parameters (the ?key=value&key2=value2 part) are how GET requests pass data. 
  In web security, we often need to test parameters for injection vulnerabilities. 
  Custom headers let us impersonate browsers, pass authentication tokens, and manipulate how the server processes your request.

  # These are practiced in python file: http_get_demo.py

# POST Requests
  POST requests send data in the request body, not in the URL. 
  Login forms, search forms, API data submission - all use POST.
  This is the most important request type for security testing, because all sensitive data travels in POST bodies.

  # These are practiced in python file: http_post_demo.py 