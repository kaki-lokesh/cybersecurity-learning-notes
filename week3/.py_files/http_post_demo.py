import requests
import json

# 1. Form POST (Content-Type: application/x-www-form-urlencoded)
# This is what happens when you click "Login" on a website
form_data = {
    'username': 'admin',
    'password': 'password123'
}
r1 = requests.post('https://httpbin.org/post', data=form_data)
# data=dict -> Content-Type: application/x-www-form-urlencoded
# Body: username=admin&password=password123
print("Form POST body received:", r1.json()['form'])
print("Content-Type sent:", r1.json()['headers']['Content-Type'])

# 2. JSON POST (Content-Type: application/json)
# APIs and modern web apps use JSON POST
json_data = {
    'username': 'admin',
    'password': 'password123',
    'remember_me': True
}
r2 = requests.post('https://httpbin.org/post', json=json_data)
# json=dict -> Content-Type: application/json
# Body: {"username": "admin", "password": "password123", "remember_me": true}
print("\nJSON POST body received:", r2.json()['json'])
print("Content-Type:", r2.json()['headers']['Content-Type'])

# 3. Sending cookies manually
cookies = {
    'PHPSESSID': 'abc123stolen456',
    'security':  'low'
}
r3 = requests.get('https://httpbin.org/cookies', cookies=cookies)
print("\nCookies server received:", r3.json()['cookies'])
# This is SESSION HIJACKING - using a stolen session cookie to impersonate a user
