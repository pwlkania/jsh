if test "$1" = ""; then
	echo "changewm <name_of_next_window_manager>"
	echo "  only works if you are using Joey's .xinitrc"
	exit 1
fi

NEXTWMFILE="$JPATH/data/nextwinman.dat"
CURRENTWMFILE="$JPATH/data/currentwinman.dat"

echo "$1" > "$NEXTWMFILE"

CWM=`cat "$CURRENTWMFILE"`
killall "$CWM"