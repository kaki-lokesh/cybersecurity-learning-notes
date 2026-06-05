#!/bin/bash

# COMMAND INJECTION
  Command Injection occurs when an application passes user-supplied input to a system shell (OS command).
  The attacker can inject additional OS commands that execute with the same privileges as the web server.
  This is often the highest-impact web vulnerability.
  "HOW IT WORKS"
  A developer writes: shell_exec("ping" . $_get['ip'])
  My input: 127.0.0.1;
  The semicolon terminates the ping command and starts a new command. The server runs 'ping 127.0.0.1' AND 'cat /etc/passwd'

# FILE UPLOAD VULNERABILITIES
  Unrestricted file upload allows an attacker to upload a file containing server-side code (a webshell).
  When accessed via the browser, the web server executes it.
  A PHP webshell is the simplest: it accepts a command in the URL and executes it on the server, returning the output.
  'Create a simple PHP webshell'
  echo '<?php system($_GET["cmd"]); ?>' > shell.php
  <?php -> PHP opening tag (server processes this as PHP)
  system() -> executes OS command
  $_GET["cmd"] -> takes the 'cmd' URL parameter as the command
  Visiting ?cmd=whoami -> server runs 'whoami' and outputs the result
