#!/bin/sh
# sed "s+^+\'\"+" | sed "s+$+\"\'+g"
sed 's+^\|$+"+g'
