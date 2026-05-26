import requests

# WITHOUT Session - cookies not persisted between requests
# Each request is independent - you'd lose your login every request
r1 = requests.get('https://httpbin.org/cookies/set/sessionid/abc123')
r2 = requests.get('https://httpbin.org/cookies')
print("Without session - cookies:", r2.json())
# Result: {} - empty; The cookie from r1 was not carried to r2

# WITH Session - cookies persisted automatically
session = requests.Session()
session.get('https://httpbin.org/cookies/set/sessionid/abc123')
r3 = session.get('https://httpbin.org/cookies')
print("With session - cookies:", r3.json())
# Result: {'cookies': {'sessionid': 'abc123'}} - cookie is remembered

# Sessions also persist headers you set once
session.headers.update({
    'User-Agent': 'Mozilla/5.0 (compatible browser)',
    'Accept-Language': 'en-US,en;q=0.5'
})
# Now all requests through this session use these headers automatically
