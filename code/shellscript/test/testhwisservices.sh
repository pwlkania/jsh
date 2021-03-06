#### TODO TODO What about all those other address: eg. open-lists.net!
#### TODO: and what about running it as a cronjob somewhere?!?!

## Functions:

function doing () {
	echo "`cursecyan`$*`cursenorm`"
}	

function good () {
	echo "`cursegreen;cursebold`$*`cursenorm`"
}

function bad () {
	echo "`cursered;cursebold`$*`cursenorm`" >&2
	FAILED=true
}

function checkWebPageForRegexp () {
	doing "Checking URL $1 for string \"$2\" ..."
	# OUTPUT=`
		# wget -nv -O - "$1" & wgpid=$!
		# sleep 10 ; kill $wgpid 2>/dev/null ## 5 seconds didn't give slow hwi enough time!
	# `
	OUTPUT=` wget -nv -O - "$1" `
	if echo "$OUTPUT" | grep "$2" > /dev/null
	then good "`cursegreen;cursebold`OK: Found \"$2\" in \"$1\" ok.`cursenorm`"
	else bad "FAILED to find \"$2\" in \"$1\"!"
	fi
}

function askPortExpect () {
	doing "Connecting to $1:$2 sending \"$3\" hoping to get \"$4\" ..."
	# NC=`which nc 2>/dev/null`
	NC=/bin/nc
	[ ! -x "$NC" ] && echo "No netcat: using telnet" && NC=`which telnet`
	RESPONSE=`
		( echo "$3" ; sleep 99 ) |
		"$NC" "$1" "$2" & ncpid=$!
		sleep 5 ; kill $ncpid 2>/dev/null
	`
	if echo "$RESPONSE" | grep "$4"
	then good "OK: Got response containing \"$4\" from $1:$2."
	else bad "FAILED to get \"$4\" from $1:$2!" >&2
	fi
}



## Perform tests:

FAILED=false

askPortExpect hwi.ath.cx 25 "HELO" "SMTP"

echo

askPortExpect hwi.ath.cx 22 whatever "OpenSSH"

echo

## This one need only be tested if Hwi is runnign Gentoo, otherwise it's allowed to fail.
# askPortExpect hwi.ath.cx 222 whatever "OpenSSH"
# 
# echo

checkWebPageForRegexp "http://hwi.ath.cx/" "How to contact Joey"

echo

checkWebPageForRegexp "https://emailforever.net/cgi-bin/openwebmail/openwebmail.pl" "Open"

echo

checkWebPageForRegexp "http://generation-online.org/" "Generation"

echo

# doing "Checking hwi's port 5432 (postgres) is firewalled."
# nmap -p 5432 hwi.ath.cx 2>/dev/null | grep "[Oo]pen" && bad "Port is open!" || good "Port is not open"

check_firewall () {
	doing "Checking hwi's port $2 ($1) is firewalled."
	nmap -p "$2" hwi.ath.cx 2>/dev/null | grep "[Oo]pen" && bad "Port is open!" || good "Port is not open"
}

check_firewall ftp 220

check_firewall nfs 2049

check_firewall samba 139

check_firewall samba 445

check_firewall "X:0" 6000

check_firewall "X:1" 6001

echo

## Report result:

if [ "$FAILED" = false ]
then
	good "All tests passed.  =)"
else
	bad "There were failures.  Please fix or report.  (But first please run \"updatejsh\" to ensure you have the latest tests.)"
	exit 99
fi
