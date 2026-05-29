import argparse

parser = argparse.ArgumentParser(
    prog='security-tool',
    description='A professional security tool demonstrating argparse',
    epilog='Example: python3 tool.py -t 192.168.1.1 -p 80,443 -v --output report.txt'
)

# Positional argument (required, no flag)
parser.add_argument(
    'target',
    help='Target IP address or hostname'
)

# Optional arguments (with flags)
parser.add_argument(
    '-p', '--ports',
    default='1-1024',
    help='Port range (default: 1-1024)'
)

parser.add_argument(
    '-T', '--threads',
    type=int,   # auto-convert string -> int, error if not valid int
    default=100,
    help='Number of threads (default: 100)'
)

parser.add_argument(
    '--timeout',
    type=float,   # float for decimal values like 1.5
    default=1.0,
    help='Connection timeout in seconds (default: 1.0)'
)

# Boolean flags (store_true/store_false)
parser.add_argument(
    '-v', '--verbose',
    action='store_true',  # flag is present -> True, absent -> False
    help='Show detailed output'
)

parser.add_argument(
    '--no-banner',
    action='store_true',
    help="Don't attempt banner grabbing"
)

# Repeatable arguments (append)
parser.add_argument(
    '-H', '--header',
    action='append',   # each -H adds to a list
    help='HTTP header (Key: Value) - can use multiple times'
)
# Usage: python3 tool.py target -H "X-Custom: abc" -H "Authorization: Bearer token"
# args.header -> ['X-Custom: abc', 'Authorization: Bearer token']

# Choices (restrict to valid values)
parser.add_argument(
    '--method',
    choices=['GET', 'POST', 'PUT', 'DELETE', 'HEAD'],
    default='GET',
    help='HTTP method (default: GET)'
)

# Output file
parser.add_argument(
    '-o', '--output',
    type=argparse.FileType('w'),  # auto-open the file, error if can't write
    help='Output file (default: stdout)',
    default=None
)

args = parser.parse_args()

# Accessing parsed values
print(f"Target:  {args.target}")   # positional -> args.target
print(f"Ports:   {args.ports}")    # --ports -> args.ports
print(f"Threads: {args.threads}")  # --threads -> args.threads (int)
print(f"Verbose: {args.verbose}")  # --verbose -> True or False
print(f"Method:  {args.method}")   # --method -> 'GET' (validated)
print(f"Headers: {args.header}")   # -H -> list or None

# Auto-generated --help output (run: python3 argparse_masterclass.py --help)