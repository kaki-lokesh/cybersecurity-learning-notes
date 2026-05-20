#!/bin/bash

# DNS DOMAIN NAME SYSTEM 
  Its also referred as "The Internet's Phone Book"
  DNS translates human-readable domain names into IP addresses that computers use. Without DNS, you would need to memorise IP addresses for every website.
  DNS is also a massive attack surface - DNS spoofing, DNS cache poisoning, DNS amplification attacks and DNS enumeration
"Full DNS Resolution Chain"
STEP1: Browser Cache Check- Browser first checks its own DNS cache
STEP2: OS Cache Check- If not in browser cache, OS checks its own DNS cache
STEP3: Hosts File Check- OS checks [(Linux) /etc/hosts] or [(Windows) C:\Windows\System32\drivers\etc\hosts {Entries here override DNS}]
STEP4: Recursive resolver- OS send query to your configured DNS server. This server does the heavy work of finding the answer.
STEP5: Root Nameservers- Recursive resolver asks one of 13 root nameserver clusters (a.root-servers.net through m.root-servers.net):"Who is responsible for .com domains?" Root returns:"Ask the .com TLD nameserver."
STEP6: TLD Nameserver- Resolver asks the .com TLD nameserver:"Who handles google.com?" TLD returns:"Ask Google's authoritative nameserver at ns1.google.com"
STEP7: Authoritative Nameserver- Resolver asks ns1.google.com: "What is the IP for google.com?" Gets back: "142.250.195.78" This is the final answer
STEP8: Response Cached and Returned- Recursive resolver caches the response (for TTL seconds), returns to OS, OS caches it, browser receives the IP and connects.

# DNS RECORD TYPES
'Record Purpose                              Example                                   Security-Use'
 A      Address-maps hostname to IPv4        google.com→ 142.250.195.78                Primary target of DNS attacks. DNS poisoning changes this record.
 AAAA   IPv6 Address-maps hostname to IPv6   google.com→ 2607:f8b0::...                IPv6 is often less monitored — attackers use IPv6 to bypass IPv4 filters.
 MX     Mail Exchange-where to deliver email google.com MX→ aspmx.l.google.com         MX records reveal email infrastructure for phishing/spam planning.
 NS     Nameserver-authoritative DNS servers google.com NS→ ns1.google.com             Zone transfer attempts target NS records to get all DNS data.
 CNAME  Canonical Name-alias for other hstnm www.google.com→ google.com                CNAME chains can be used for subdomain takeover attacks.
 TXT    Text-arbitrary text (SPF, DKIM)      google.com TXT→ "v=spf1 include:..."      SPF/DKIM records reveal email authentication setup. Missing SPF = email spoofable.
 PTR    Pointer-reverse DNS (IP->hstnm)      142.250.195.78→ iad30s08-in-f14.1e100.net Reverse DNS lookup during investigation - find company name from IP address.
 SOA    Start Of Authority-zone admin info   Serial number, refresh interval           Reveals primary nameserver and admin email (sometimes organizational intel).
# DNS TOOLS
# dig : The most powerful DNS query tool
  Syntax- dig <CNAME>
Query specific record types:
1. dig google.com MX 
2. dig google.com TXT
   SPF record - specifies which mail servers can send email from @google.com
   ~all = softfail (emails from other servers are suspicious but not blocked)
   -all = hardfail (emails from other servers should be rejected)
# dig <@IP> <CNAME> : Use a specific DNS server to resolve (bypass default)
  @1.1.1.1 = Cloudflares DNS, @8.8.8.8 = Google DNS
  Useful when you suspect your default DNS is poisoned
# dig -x <IP> : Reverse DNS - IP to hostanme
# DNS Enumeration
1. theHarvester -d <CNAME> -b all : find subdomains, email addresses, hosts (IPs) from a target domain
2. dnsenum <CNAME> : Enumerate all subdomains of a domain

# DNS SECURITY ATTACKS
1. 'DNS Cache Poisoning'- Attackers tricks a recursive resolver into caching a fake DNS record. 
   All users of that resolver get the attacker's IP for the poisoned domain.
   (Kaminsky attack, 2008 - affected millions of DNS servers)
2. 'DNS Amplification DDoS'- Attacker sends DNS queries with spoofed source IP (victim's IP).
   DNS servers send large responses to victim. Amplification factor can be 40-100x (small query → massive response).
3. 'DNS Tunneling'- Attacker encodes data in DNS queries to exfiltrate data from a network that blocks all traffic except DNS.
   Firewalls typically allow DNS (port 53)- attackers abuse this.
