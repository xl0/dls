#!/bin/bash

if [ -d $1 ] ; then
	avconv -r 15 -i $1/frame_%6d.png  -r 30  -vcodec qtrle $1/video.mov
	rm -fr $1/*.png
else
	echo "No video for this one"
fi

