## startkde is slow and worst of all it keeps its loading banner on top of other windows even when they become usable.
## kdelight is intended to start the kwin window manager ASAP, without breaking KDE.  (Thus is actually starts kdeinit first.)
## it also starts the KDE panel kicker, but you don't get a desktop, or any other business startkde might bring with it.

# kwin > /tmp/kwin-$DISPLAY.log 2>&1 &
# sleep 2
# kicker > /tmp/kicker-$DISPLAY.log 2>&1 &
# wait

## This script was tested with kicker and konqueror already loading in the background.
## TODO: Test without.

jshinfo "[kdelight] Starting kdeinit"

## So that Konqueror doesn't break, we need to start kdeinit ASAP:
kdeinit > /tmp/kdeinit-$DISPLAY.log 2>&1 &
## Otherwise klauncher doesn't work properly (although we don't need to load it):
# klauncher > /tmp/klauncher-$DISPLAY.log 2>&1 &

sleep 2
## We want the panel:
(
	sleep 3
	jshinfo "[kdelight] Starting kicker"
	kicker > /tmp/kicker-$DISPLAY.log 2>&1
) &
# kicker > /tmp/kicker-$DISPLAY.log 2>&1 &

jshinfo "[kdelight] Starting kwin"

## Finally the WM!:
kwin > /tmp/kwin-$DISPLAY.log 2>&1
