if test "$1" = "-multi"
then
	shift
	MULTICDRECORD="-multi -nofix -data"
	MULTIMKISOFS="-M 0,0,0"
	NEXT_TRACK=`cdrecord -msinfo dev=0,0,0 2>/dev/null`
	if test "$NEXT_TRACK" = ""
	then echo "Looks like a new disk to me."
	else MULTIMKISOFS="$MULTIMKISOFS -C $NEXT_TRACK"
	fi
	echo "Using mkisofs options: $MULTIMKISOFS"
	echo "Using cdrecord options: $MULTICDRECORD"
fi

## Worked for me as initial write:
## Removed inaccurate tsize=359232s (means 700, but did work!), may need to use mkisofs -print-size
## -eject
cursegreen
echo "nice --20 mkisofs -r -J -jcharset default -f -l -D -L -V -P -p -abstract -biblio -copyright -graft-points /="$1" $MULTIMKISOFS | nice --20 cdrecord dev=0,0,0 fs=4096k -v speed=2 -pad $MULTICDRECORD -overburn -"
cursenorm
      nice --20 mkisofs -r -J -jcharset default -f -l -D -L -V -P -p -abstract -biblio -copyright -graft-points /="$1" $MULTIMKISOFS | nice --20 cdrecord dev=0,0,0 fs=4096k -v speed=2 -pad $MULTICDRECORD -overburn -

## From HOWTO (does multi)
# mkisofs -R -o cd_image2 -C $NEXT_TRACK -M /dev/scd5 private_collection/

if test ! "$?" = 0
then exit
fi



### Post-write checksumming (to check write OK, and to keep handy file index)

sleep 10
cursecyan

CDLDIR=/stuff/cdlistings

centralise "Checksumming directory"
cd "$1"
$CDLDIR/findaz.sh | tee $CDLDIR/newcd.qkcksum.sb

centralise "Checksumming cdrom"
mount /mnt/cdrom1
cd /mnt/cdrom1
$CDLDIR/findaz.sh | tee $CDLDIR/newcd.qkcksum

centralise "Comparing cksums"
jfcsh -bothways $CDLDIR/newcd.qkcksum.sb $CDLDIR/newcd.qkcksum

if cmp $CDLDIR/newcd.qkcksum.sb $CDLDIR/newcd.qkcksum
then echo "CD written OK =)"
else echo "Oh dear: $CDLDIR/newcd.qkcksum.sb and $CDLDIR/newcd.qkcksum should match."
fi