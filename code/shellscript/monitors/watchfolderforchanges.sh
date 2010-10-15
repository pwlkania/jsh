#!/bin/sh
[ "$DELAY" ] || DELAY=15
TARGET_DIRS="$*" ## BUG: Fails on dirs with spaces.  Could fix with: for X in "$@"; do ...
jwatch "find $TARGET_DIRS -maxdepth 4 -type f | withalldo nicels -ld" 2>&1 | dateeachline
