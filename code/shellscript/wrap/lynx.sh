#!/bin/sh
# jsh-depends: unj
if [ ! "$*" ]
then unj lynx http://hwi.ath.cx/jumpgate.html
else unj lynx "$@"
fi
