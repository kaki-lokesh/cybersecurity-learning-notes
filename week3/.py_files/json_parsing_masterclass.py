import json
import requests

# "JSON Structure -> Python Types"
# JSON objects {} -> Python dict
# JSON arrays  [] -> Python list
# JSON strings "" -> Python str
# JSON numbers    -> Python int or float
# JSON true/false -> Python True/False
# JSON null       -> Python None

api_response_json = """
{
  "ip": "8.8.8.8",
  "hostname": "dns.google",
  "org": "AS15169 Google LLC",
  "country": "US",
  "city": "Mountain View",
  "loc": "37.4056,-122.0775",
  "tags": ["malware", "suspicious"],
  "ports": [53, 443, 853],
  "is_malicious": false,
  "last_seen": null,
  "services": {
    "53": {"name": "DNS",  "version": "BIND 9.x"},
    "443": {"name": "HTTPS", "version": "nginx/1.18"}
  }
}
"""

# Parse JSON string into Python object
data = json.loads(api_response_json)  # string -> dict

# Basic field access
print("IP:",       data['ip'])              # '8.8.8.8'
print("Org:",      data['org'])             # 'AS15169 Google LLC'
print("Country:", data['country'])          # 'US'

# Safe access with .get() - never crash on missing keys
# data['nonexistent'] -> KeyError crash
# data.get('nonexistent') -> None (safe)
# data.get('nonexistent', 'DEFAULT') -> 'DEFAULT' (with fallback)
asn     = data.get('asn', 'Unknown')      # key doesn't exist -> 'Unknown'
malicious = data.get('is_malicious', False) # exists -> False
print(f"ASN: {asn} | Malicious: {malicious}")

# Lists (arrays)
tags = data['tags']     # ['malware', 'suspicious']
print("Tags:", ', '.join(tags))    # 'malware, suspicious'

ports = data['ports']    # [53, 443, 853]
print("Open ports:", ports)
if 443 in ports:
    print(" -> HTTPS service is running")

# Nested dicts
services = data['services']    # {'53': {...}, '443': {...}}
for port, info in services.items():
    print(f"  Port {port}: {info['name']} v{info['version']}")

# None handling
last_seen = data.get('last_seen')
if last_seen is None:
    print("Last seen: Never recorded")

# Real API Example: IPinfo.io (free, no key needed)
print("\nReal API Call")
r = requests.get('https://ipinfo.io/8.8.8.8/json')
ip_data = r.json()
print(f"Real data for 8.8.8.8:")
for field in ['ip', 'hostname', 'org', 'city', 'country']:
    print(f"  {field}: {ip_data.get(field, 'N/A')}")