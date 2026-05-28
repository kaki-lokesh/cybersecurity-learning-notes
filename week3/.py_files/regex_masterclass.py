import re

TEXT = """
Threat Report: APT-29 Activity
The malware contacted C2 server at 192.168.100.50 and 10.0.0.1
Domain: evil-c2-domain.ru and another.malware.com were observed
Attacker email: hacker@evil.org was used for spear phishing
File hash MD5: d41d8cd98f00b204e9800998ecf8427e
SHA256: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
The URL http://evil.ru/payload.exe was downloaded from https://malware.net/stage2.dll
User credentials: admin:Password123! were found in the config
"""

# Pattern 1: IPv4 addresses
# Matches 4 groups of 1-3 digits separated by dots
IP_PATTERN = re.compile(r'\b(?:(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\b')
ips = IP_PATTERN.findall(TEXT)
print("IP Addresses:", ips)
# -> ['192.168.100.50', '10.0.0.1']

# Pattern 2: Domain names (simplified)
DOMAIN_PATTERN = re.compile(
    r'\b(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+(?:com|net|org|ru|cn|info|biz|io|co)\b'
)
domains = DOMAIN_PATTERN.findall(TEXT)
print("Domains:", list(set(domains)))  # set() removes duplicates
# -> ['evil-c2-domain.ru', 'another.malware.com', 'evil.org', ...]

# Pattern 3: Email addresses
EMAIL_PATTERN = re.compile(r'\b[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}\b')
emails = EMAIL_PATTERN.findall(TEXT)
print("Emails:", emails)
# -> ['hacker@evil.org']

# Pattern 4: MD5 hashes (32 hex characters)
MD5_PATTERN = re.compile(r'\b[0-9a-fA-F]{32}\b')
md5s = MD5_PATTERN.findall(TEXT)
print("MD5 hashes:", md5s)
# -> ['d41d8cd98f00b204e9800998ecf8427e']

# Pattern 5: SHA-256 hashes (64 hex characters)
SHA256_PATTERN = re.compile(r'\b[0-9a-fA-F]{64}\b')
sha256s = SHA256_PATTERN.findall(TEXT)
print("SHA-256 hashes:", sha256s)

# Pattern 6: URLs
URL_PATTERN = re.compile(r'https?://[^\s<>"{}|\\^`\[\]]+[^\s<>"{}|\\^`\[\].,;)]')
urls = URL_PATTERN.findall(TEXT)
print("URLs:", urls)
# -> ['http://evil.ru/payload.exe', 'https://malware.net/stage2.dll']

# Pattern 7: Using capture groups to extract specific parts
# Extract username:password patterns
CRED_PATTERN = re.compile(r'\b(\w+):([^\s]+)')
credentials = CRED_PATTERN.findall(TEXT)
for user, pwd in credentials:
    if len(pwd) >= 6:  # Filter out short false positives
        print(f"Possible credential - User: {user}, Password: {pwd}")

