if test "x$1" = "x" -o "x$2" = "x"; then
	echo "undelext2 <lsdelfile> <destdir> | debugfs <fsdevice>"
	echo "will recover your files"
	exit 1
fi

N=0;
cut -c1-6 $1 | grep "[0-9]" | tr -d " " | while read X; do echo "dump <$X> $2/undel-$N"; N=$[$N+1]; done
