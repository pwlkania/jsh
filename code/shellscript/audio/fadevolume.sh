if test $1; then
  GAP=$1
else
  GAP=60
fi

DONE=
while test ! $DONE; do
  VOL=`aumix -q | grep "vol" | after "vol " | before ","`
  VOL=$(($VOL-1))
  echo $VOL
  aumix -v $VOL
  if test "$VOL" = "0" || test "$VOL" = "-1"; then
    DONE=true
  else
    sleep $GAP
  fi
done

# killall mpg123; mykill "music"; killall mp3blaster
# xmms -t &
# sleep 3
## Doesn't work with music(2|)
# aumix -v 50
