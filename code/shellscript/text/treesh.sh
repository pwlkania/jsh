[ "$DEBUG" ] && . importshfn debug

NL="
"

commonstring () {
	## To test how much of "$2" matches with "123", build regexp like:
	##   "(1(2(3|)|)|)"
	echo "$FIRSTLINE" |
	sed "s+.+\0\\$NL+g" |
	grep -v "^$" |
	(
	while read CHAR
	do
		REGEXPHEAD="$REGEXPHEAD\($CHAR"
		REGEXPEND="\|\)$REGEXPEND"
	done
	REGEXP="$REGEXPHEAD$REGEXPEND"
	# echo "+$REGEXP+"
	echo "$SECONDLINE" |
	sed "s+$REGEXP.*+\1+"
	)
}

COMMONSOFAR=""
CURRENTCOMMON=""

read FIRSTLINE

while read SECONDLINE
do

	[ "$DEBUG" ] && debug
	[ "$DEBUG" ] && debug "commonsofar:"
	# echo "$COMMONSOFAR"
	[ "$DEBUG" ] && debug "first         = $FIRSTLINE"
	[ "$DEBUG" ] && debug "second        = $SECONDLINE"
	COMMON=`commonstring "$FIRSTLINE" "$SECONDLINE"`
	[ "$DEBUG" ] && debug "common        = $COMMON"

	NOTABOVE=`startswith "$COMMON" "$CURRENTCOMMON" && echo yes`
	NOTBELOW=`startswith "$CURRENTCOMMON" "$COMMON" && echo yes`
	SAME=`[ "$COMMON" = "$CURRENTCOMMON" ] && echo yes`

	[ "$DEBUG" ] && debug "notabove      = $NOTABOVE"
	[ "$DEBUG" ] && debug "notbelow      = $NOTBELOW"
	[ "$DEBUG" ] && debug "same          = $SAME"

	if [ ! $SAME ] && [ $NOTABOVE ]
	then
		[ "$DEBUG" ] && debug ">>>>"
		COMMONSOFAR="$COMMONSOFAR$NL$COMMON"
		CURRENTCOMMON="$COMMON"
		echo "+ $CURRENTCOMMON {"
	fi

	echo ". $FIRSTLINE$APPEND"

	if [ ! $SAME ] && [ $NOTBELOW ]
	then
		while ! startswith "$SECONDLINE" "$CURRENTCOMMON"
		do
			[ "$DEBUG" ] && debug "<<<<"
			echo "- $CURRENTCOMMON }"
			COMMONSOFAR=`echo "$COMMONSOFAR" | chop 1`
			CURRENTCOMMON=`echo "$COMMONSOFAR" | tail -1`
			[ "$DEBUG" ] && debug "newcurrentcommon = $CURRENTCOMMON"
		done
	fi

	FIRSTLINE="$SECONDLINE"

done

echo "Finally: $SECONDLINE"
