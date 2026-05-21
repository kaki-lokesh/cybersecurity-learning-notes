#!/bin/bash

# HTTP HYPERTEXT TRANSFER PROTOCOL
  HTTP is the protocol underlying every web interaction
  Every web security vulnerability (SQLi, XSS, CSRF, IDOR) is exploited by crafting malicious HTTP requests.
# HTTP Methods
'Method  Purpose                        	 Security Notes'
 GET	 Retrieve a resource. Parameters in URL  Parameters visible in logs, history, browser cache. Never use GET for sensitive data.
 POST	 Submit data to server.                  Body in request - Body not in URL - but still interceptable! Burp Suite captures POST bodies. Login forms use POST.
 PUT	 Replace entire resource with new data	 If misconfigured (no auth), allows file upload/overwrite. Common IDOR vulnerability path.
 DELETE	 Delete a resource 	                 IDOR: DELETE /user/123 - can you delete another user by changing 123 to 124?
 PATCH	 Partial update to a resource 	         Same IDOR risk as PUT/DELETE. Mass assignment vulnerabilities.
 OPTIONS Ask server what methods are allowed     Reconnaissance - reveals what APIs are available. Can expose CORS misconfigurations.
 HEAD	 Like GET but returns only headers       Used in recon - check if resource exists without downloading it.
          (no body)
# HTTP Status Codes
'Code	 Meaning	         Security Significance'
 200	 OK — success	         Request worked. If you're testing for IDOR, a 200 on another users resource = vulnerability.
 301/302 Redirect	         Open redirects - attacker makes you redirect to malicious site.
 400	 Bad Request	         Malformed request. Useful when fuzzing - unexpected 400 vs 200 reveals different app behavior.
 401	 Unauthorized	         Authentication required. If this changes to 200 with parameter manipulation = auth bypass.
 403	 Forbidden	         Authenticated but not authorized. IDOR: 403 on others' resources that should → 200.
 404	 Not Found	         Resource doesn't exist. Directory brute forcing watches for non-404 responses.
 500	 Internal Server Error   Often reveals stack traces, error messages, database info. SQLi payloads often trigger 500s.
 502/503 Bad Gateway/Unavailable Server-side error. DoS attack success indicator.
# HTTP HEADERS
  HTTP headers carry metadata about both requests and responses.
  HTTP headers is critical for security: cookie theft, session management attacks, CSRF, content injection, clickjacking.

=================HTTP REQUEST (Client → Server) =================
# "POST /login HTTP/1.1"
   ↑ Method + Path + HTTP Version
  Host: dvwa.example.com
  ↑ REQUIRED in HTTP/1.1. Allows virtual hosting — multiple sites on one IP.
  Host header injection attack: modify Host to bypass auth or access admin panels.

  User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
  ↑ Identifies the browser/tool making the request. Can be SPOOFED.
  When you see "python-requests/2.28" in access logs = automated script/tool.
  User-Agent "sqlmap/1.7" in logs = someone is running SQLmap against you!

  Content-Type: application/x-www-form-urlencoded
  ↑ Format of the request body. IMPORTANT for attacks:
  application/x-www-form-urlencoded = standard form submission (key=value&key=value)
  application/json = JSON API ({"username":"admin"})
  multipart/form-data = file upload. Changing Content-Type can bypass file type checks!

  Cookie: PHPSESSID=abc123def456; security=low
  ↑ Session cookies - MOST SECURITY-CRITICAL HEADER in web apps.
  PHPSESSID = PHP session identifier. Steal this cookie = steal the session = hijack account.
  XSS attacks steal cookies via document.cookie. This is WHY XSS is critical severity.
  HttpOnly flag on cookies prevents JavaScript from reading them → XSS protection.

  Content-Length: 38
  ← blank line separates headers from body
  username=admin&password=password123
  ↑ This is the request BODY. In Burp Suite, this is what you modify for SQLi:
  username=admin' OR '1'='1'-- -&password=anything

================== HTTP RESPONSE (Server → Client) ====================
# "HTTP/1.1 200 OK"

  Server: Apache/2.4.51 (Ubuntu)
  ↑ INFORMATION DISCLOSURE — tells attacker exactly what software version is running.
  Best practice: remove or obscure this header. An attacker searches: Apache 2.4.51 CVE

  Set-Cookie: PHPSESSID=newtoken789; Path=/; HttpOnly; Secure; SameSite=Strict
  HttpOnly = JavaScript cannot read this cookie (XSS protection)
  Secure = only sent over HTTPS (prevents HTTP sniffing)
  SameSite=Strict = not sent with cross-site requests (CSRF protection)
  Missing any of these flags = vulnerability in a security audit!

  X-Frame-Options: DENY
  ↑ Prevents page from being embedded in iframes. Protects against Clickjacking attacks.
  Missing = clickjacking vulnerability!

  Content-Security-Policy: default-src 'self'; script-src 'self' 'nonce-xyz'
  ↑ CSP restricts what scripts can execute. Strong CSP blocks XSS attacks.
  Missing CSP = XSS is much easier to exploit.
  Weak CSP (unsafe-eval, unsafe-inline) = CSP bypass possible.

# HTTPS & TLS
  HTTPS is simply HTTP wrapped in TLS (Transport Layer Security) encryption.
  Before any HTTP data is sent, TLS performs a handshake that:
  1. authenticates the server (via certificates) 
  2. negotiates encryption algorithms
  3. establishes a shared secret key
  4. After the handshake, all HTTP data is encrypted.
# TLS Handshake
  1. ClientHello: Your browser says "I support TLS 1.3, here are my cipher suites (AES-256-GCM, ChaCha20), here's my random number"
  2. ServerHello: Server responds: "Let's use TLS 1.3 with AES-256-GCM. Here's MY random number. Here's my certificate"
  3. Certificate Verification: Your browser checks the server's certificate: Was it signed by a trusted CA (Certificate Authority)? Is the hostname matching? Is it expired?
  4. Key Exchange: Using asymmetric crypto (RSA or ECDH), both sides agree on a shared 'session key' - without ever transmitting the key itself
  5. Finished: Both sides confirm the handshake. All subsequent data is encrypted with the session key using AES-256 (symmetric, fast)

