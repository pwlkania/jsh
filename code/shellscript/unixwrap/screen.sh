## screen (this script) with no args should only be interactive when run
## by user directly from shell, so make interactivity an option, and make
## an alias for it.

# export SCREEN_RUNNING=true
export DISPLAY=

## This _might_ get it to buggy if problems persist:
# export WINNAMEW
export STY

if test "$*"
then

	unj screen "$@"

else

	echo "Once attached, press Ctrl+k then ? for help."
	echo "To reach deeper screens, press Ctrl+k then Ctrl+l's."
	unj screen -list
	# sleep 1
	# DEFNAME=`hostname | beforefirst "\."`
	DEFNAME="$SHORTHOST"
	echo "Type session name to attach or start new (<Enter> defaults to \"$DEFNAME\")."
	read NAME
	test "$NAME" || NAME="$DEFNAME"
	test "$NAME" || NAME=screen
	export SCREENNAME="$NAME"
	screentitle -remote "[$SHORTHOST:$SCREENNAME]"
	screen -h 10000 -a "-e^k^l" -S "$NAME" -D -RR

fi
