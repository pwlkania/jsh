#!/bin/sh
sed 's+\(.*\)/\(.*\)+"\2" \1/\2+' | sort -f -k 1 | sed 's+.*" ++'
