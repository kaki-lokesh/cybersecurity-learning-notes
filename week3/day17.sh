#!/bin/bash

# REST API
  A REST API is an interface that lets one program talk to another over HTTP
  Security databasese - Shodan (exposed services), VirusTotal (malware analysis), AbuselPDB (IP reputation), NVD (CVE database) - all expose REST APIs
  Every API call follows the same pattern:
  1. send a GET or POST request to a specific URL with your API key in a header or parameter
  2. receive JSON in response
  3. parse the JSON
  4. extract the fields you need

# JSON
  JavaScript Object Notation (JSON) is the universal data exchange format for APIs
  It maps directly to python dictionaries and lists

  # This concept is practiced in python file: json_parsing_masterclass.py

