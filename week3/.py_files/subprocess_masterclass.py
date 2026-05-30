import subprocess
import shlex
import os

# subprocess.run() - the modern way
# Always use a LIST of arguments, never a string with shell=True
# shell=True with user input -> command injection vulnerability

# Run a command and capture output
result = subprocess.run(
    ['nmap', '-sV', '-p', '22,80,443', '127.0.0.1'],
    capture_output=True,  # captures stdout and stderr
    text=True,   # decode bytes -> str automatically
    timeout=60   # kill if takes longer than 60 seconds
)
print("Return code:", result.returncode)  # 0 = success, non-0 = error
print("stdout:", result.stdout)
print("stderr:", result.stderr)   # Nmap info goes to stderr sometimes

# Check if a tool exists before running it
def check_tool(tool_name):
    """Return True if tool is available in PATH"""
    result = subprocess.run(
        ['which', tool_name],
        capture_output=True, text=True
    )
    return result.returncode == 0

print("Nmap available:", check_tool('nmap'))
print("sqlmap available:", check_tool('sqlmap'))

# Environment variables
# NEVER hardcode API keys in code. Use environment variables.
api_key = os.environ.get('VIRUSTOTAL_API_KEY')
if api_key:
    print(f"API key loaded: {api_key[:8]}...")
else:
    print("Warning: VIRUSTOTAL_API_KEY not set")
    print("Set with: export VIRUSTOTAL_API_KEY='your-key-here'")

# SECURITY WARNING: Never do this!
# user_input = "127.0.0.1; rm -rf /"  <- attacker input
# subprocess.run(f"nmap {user_input}", shell=True)  <- COMMAND INJECTION
# The semicolon executes a second command. Always use list form.
# subprocess.run(['nmap', user_input]) <- Safe: nmap treats it as one argument