# xterm -fg black -bg white -geometry 68x60 -e "man $*"
# whitewin -geometry 68x60 -e "man $*"
WIDTH=`man $* | col -bx | longestline`
WIDTH=`expr $WIDTH + 2`
whitewin -geometry "$WIDTH"x60 -e "man $*"
# export PAGER=`which cat`
# whitewin -si -geometry "$WIDTH"x60 -e "man $*"
