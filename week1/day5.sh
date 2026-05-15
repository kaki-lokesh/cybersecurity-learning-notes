#!/bin/bash

# BASH SCRIPTING
  A bash script is a file containing a sequence of Linux commands that execute together.
  Every time you find yourself running the same sequence of commands twice — write a script.
# nano <file>.sh : create and edit bash file
FORMAT- #!/bin/bash
        <commands>
Save in nano: Ctrl+O, Enter, Ctrl+X
# chmod +x <file>.sh [=>] <file>.sh : Execute bash file

━━━━━━━━━━━━━━━━━━━━━━ VARIABLES ━━━━━━━━━━━━━━━━━━━━━━━━━
NAME="CyberStudent"
AGE=21
echo "Name: $NAME, Age: $AGE"
NO SPACES around = when assigning. NAME = "value" is WRONG.
Access with $NAME or ${NAME}. ${NAME} safer inside strings.
━━━━━━━━━━━━━━━━━━━━━━ IF / ELSE ━━━━━━━━━━━━━━━━━━━━━━━━━
#!/bin/bash
NUM=-56
if [ "$NUM" -gt 0 ]; then echo
elif [ "$NUM" -eq 0 ]; then echo 
else echo 
fi
-gt = greater than, -lt = less than, -eq = equal, -ne = not equal
For strings: = (equal), != (not equal), -z (empty string), -n (not empty)
For files: -f (is file), -d (is directory), -e (exists)
━━━━━━━━━━━━━━━━━━━━━━ FOR LOOPS ━━━━━━━━━━━━━━━━━━━━━━━━━
#!/bin/bash
for IP in 192.168.1.1 192.168.1.2 192.168.1.3; do 
echo "$IP"
done
$? = exit code of last command. 0 = success, anything else = failure
━━━━━━━━━━━━━━━━━━━━ ARGUMENTS ($1, $2) ━━━━━━━━━━━━━━━━━━━
#!/bin/bash
# Usage: ./script.sh logfile.txt 10
LOGFILE="$1" # First argument
THRESHOLD="$2" # Second argument
if [ -z "$LOGFILE" ]; then
echo "Usage: $0 <logfile> <threshold>"
exit 1
fi


# CRON JOBS
  Cron is Linux's task scheduler. It runs commands automatically at specified times.
  Security relevance: 
  (1) Analysts schedule automated checks. 
  (2) Attackers use cron for persistence

# Cron schedule format:
┌────────── minute (0-59)
│ ┌──────── hour (0-23)
│ │ ┌────── day of month (1-31)
│ │ │ ┌──── month (1-12)
│ │ │ │ ┌── day of week (0-7, 0&7=Sunday)
│ │ │ │ │
* * * * * /path/to/command

# Common examples:
0   * * * * = Every hour at minute 0
0   0 * * * = Every day at midnight
*/5 * * * * = Every 5 minutes
0   9 * * 1 = Every Monday at 9:00 AM
30  6 * * * = Every day at 6:30 AM
*   * * * * = Every minute

# crontab -e : edit your crontab
FORMAT- [* * * * *] <file>.sh >> <file>.log 2>&1
# crontab -l : list your current cron jobs
FORMAT- * * * * * <file>.sh >> <file>.log 2>&1
# cat /etc/crontab : check for suspicious cron jobs

