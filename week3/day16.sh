#!/bin/bash

# HTTP SESSIONS
  HTTP is stateless - each request is independent. The server has no memory of previous requests.
  Sessions solve this by giving you a cookie after login that identifies your "session"
  The server maps this cookie to your login state in its database.
  Every subsequent request you make carries this cookie, and the server knows who you are.

  'requests.Sessions()' automatically handles cookies across multiple requests - exactly what a browser does.

  # This concept is practised in python file: session_demo.py

# BEAUTIFULSOUP
  Many web forms include a hidden CSRF token - a random value the server generates and embeds in the form.
  When the form is submitted, the server checks that this token matches what it gave you.
  This prevents Cross-Site Request Forgery attacks.

  'BeautifulSoup' parses HTML and lets you find elements, extract attributes, and navigate the document structure.

  # This concept is practised in python file: beautifulsoup_demo.py
