import requests

# 1. GET with URL parameters
# Build URL manually: ?search=python&page=2
# OR pass parameters as a dict - requests build the URL:
params = {
    'search':'python security',
    'page':  2,
    'limit': 10
}
r = requests.get('https://httpbin.org/get', params=params)
print("URL with params:", r.url)
# -> https://httpbin.org/get?search=python+security&page=2&limit=10
print("Args received:", r.json()['args'])

# 2. Custom Headers - User-Agent spoofing
# Default User-Agent is 'python-requests/2.31.0'
# Servers see this and may block automated requests
# Solution: spoof a browser User-Agent
headers = {
    'User-Agent':      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0',
    'Accept':          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate',
    'Connection':      'keep-alive',
}
r2 = requests.get('https://httpbin.org/headers', headers=headers)
print("\nHeaders server saw:")
for key, val in r2.json()['headers'].items():
    print(f"  {key}: {val}")

# 3. Handling redirects — critical for web security testing
# By default, requests FOLLOWS redirects (301, 302)
r3 = requests.get('https://httpbin.org/redirect/3')
print(f"\nFollowed {len(r3.history)} redirects")
print("Final URL:", r3.url)
for redirect in r3.history:
    print(f"  Redirect: {redirect.status_code}->{redirect.headers.get('Location')}")

# Don.t follow redirects (see the raw 302 response)
# CRITICAL for open redirect testing
r4 = requests.get('https://httpbin.org/redirect/1', allow_redirects=False)
print(f"\nWithout redirect follow: {r4.status_code}")
print("Location header:", r4.headers.get('Location'))

# 4. Timeouts — always set these in security tools
try:
    r5 = requests.get('https://httpbin.org/delay/10', timeout=3)
    # timeout=3 means: wait max 3 seconds for a response
    # The delay/10 endpoint takes 10 seconds -> timeout fires
except requests.exceptions.Timeout:
    print("\nTimeout! Server took too long. (Expected for this demo)")
except requests.exceptions.ConnectionError:
    print("Connection failed - host unreachable")