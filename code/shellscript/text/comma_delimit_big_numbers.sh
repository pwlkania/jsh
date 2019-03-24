#!/bin/sh
# A simple script that turns 1234567 into 1,234,567
# Does not yet do anything after the decimal point.  Maybe in future...
# Does not scale beyond billions

exec sed '
  s+\([0-9][0-9]*\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)+\1,\2,\3,\4,\5+
  s+\([0-9][0-9]*\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)+\1,\2,\3,\4+
  s+\([0-9][0-9]*\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)+\1,\2,\3+
  s+\([0-9][0-9]*\)\([0-9][0-9][0-9]\)+\1,\2+
'
