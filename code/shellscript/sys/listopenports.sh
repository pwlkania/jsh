#!/bin/sh

# See also: whatisonport

# -t = show only TCP (remove -t and optionally add -u if you want to see UDP listeners)
# -l = show only listening ports; if you want to see outgoing connections remove the -l and the `grep LISTEN`
# -p = show PID and program name (not available on BSD!)
# -n (netstat) = do not resolve hostnames (which would be slow)
# -n (ss)      = do not resolve port names

if which ss >/dev/null 2>&1
then
	# Apparently ss can show us some data that netstat cannot
	# Available on Linux but not on macOS
	sudo ss -ntlp
	exit
fi

if netstat --version 2>&1 | grep '^net-tools '
then
	# This is Linux netstat
	sudo netstat -ntlp | grep LISTEN
	exit
else
	# Assume BSD/macOS netstat
	sudo netstat -n | grep LISTEN
fi

# Old way; much slower (but shows lots of detail; more than we need!)
optionalProcessName="$1"
# Don't lookup hostnames: -n
lsof -P -S 2 -V |
grep --line-buffered "^$optionalProcessName" |
grep --line-buffered ":" |
grep --line-buffered -v "\<REG\>" |
grep --line-buffered -v "Permission denied"
# highlight blue ".*Permission denied.*"
