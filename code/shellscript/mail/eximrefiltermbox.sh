## I couldn't find a way for exim to accept the mail as if it was just received by exim and should be re-processed.
## I would have to talk SMTP for that, or maybe even that wouldn't work.  :-/

## BUG: adds extra headers each time round

## BUGS: formail appears to add an extra line at the bottom of each message (or is it only the last msg in each mbox?); this changes the message id :-/

## TODO: Could make $COMMAND a call back to eximrefiltermbox, which will only process mails matching user selection (eg. mail contains grep expression).

if [ "$UID" = 0 ]
then
	echo "Need to change \$USER in script to correct user innit."
	exit 1
fi

TEST=
if [ "$1" = -test ]
then TEST=true; shift
fi

MBOX="$1"
cp "$1" /tmp/mbox

if [ "$TEST" ]
then COMMAND="/usr/sbin/exim -bf $HOME/.forward"
else COMMAND="/usr/sbin/exim -bm $USER"
fi

cat /tmp/mbox | formail -s $COMMAND |

highlight "^Save message to: .*"

# ## I was worried it would add more headers, making the mails get long if repeated.
# ## But this dodgy method actually makes the headers shorter!
# 
# ## BUG: Breaks headers
# 
# . mailtools.shlib
# 
# COUNT=`mailcount`
# for N in `seq 1 $COUNT`
# do
# 
	# WHO=`getmail $N | grep "^From: " | head -n 1 | sed 's+From: ++'`
# 
	# echo "### $N <- $WHO"
# 
	# getmail $N |
	# grep -v "^boundary=\"" | ## headers still break.
	# grep -v "^From " | ## cos for some reason these were all marked the same, so I used $WHO instead.
# 
	# if [ "$TEST" ]
	# then /usr/sbin/exim -f "$WHO" -bf ~/.forward
	# else /usr/sbin/exim -f "$WHO" -bm $USER
	# fi
# 
	# echo
# 
# done
