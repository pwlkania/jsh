ARGS="$@"
if [ "$ARGS" = "" ]; then
  IMAGES="*.jpg *.jpeg *.bmp *.xpm *.gif *.pgm *.ppm *.pcx"
else
  IMAGES="$ARGS"
fi

HTMLFILE="_ImageIndex.html"

EXTRAS="-geom 100"
# EXTRAS=""

echo "<html><body>" > $HTMLFILE
# forall -shell $IMAGES do convert $EXTRAS %w browsepics%n.Jpeg : echo "\"<image src=\\\"browsepics%n.Jpeg\\\"><br>%w<br><br>\"" %p%p $HTMLFILE
n=0
for w in $IMAGES; do
  echo "$n: $w"
  n=$[$n+1]
  # convert $EXTRAS $w browsepics$n.Jpeg
  echo "<image src=\"browsepics$n.Jpeg\"><br>$w<br><br>" >> $HTMLFILE
done
echo "</body></html>" >> $HTMLFILE

browse $HTMLFILE

echo "browsepics*.Jpeg and $HTMLFILE will be deleted in 60 seconds"
(sleep 60 ; "rm" browsepics*.Jpeg $HTMLFILE) &