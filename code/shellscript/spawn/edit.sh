if xisrunning; then
	editandwait $* &
else
	editandwait $*
fi

# FILE="$1"
# if [ "$FILE" = "-f" ]; then
#   FORCE=true;
#   FILE="$2"
# fi
# if test ! "$FORCE"; then
#   if test ! -f "$FILE"; then
#     echo "$FILE is not a file."
#     exit 1
#   fi
# fi

# case $TERM in
#   xterm)
#     # Pipe stdout because used to get KCharset errors!
#     if test "$JWHICHOS" = "unix"; then
#       dtpad -statusLine "$FILE" &
#     elif test "$JWHICHOS" = "linux"; then
#       kwrite "$FILE" > /dev/null 2>&1 &
#     else
#       echo "Using X but unknown OS, using pico"
#       pico -w "$FILE"
#     fi
#     ;;
#   *)
#     pico -w ""$FILE""
#     ;;
# esac

