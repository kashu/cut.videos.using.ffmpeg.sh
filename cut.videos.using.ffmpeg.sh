#!/bin/bash
#Author: kashu
#Github: https://github.com/kashu
#Date: 2018-01-20
#Filename: cut.videos.using.ffmpeg.sh
#Description: 

#START=00:00:22
START=${1}
CUTTING=${2}

if [ "$2" -eq "0" ]; then 
	FFMPEG(){ ffmpeg -y -hide_banner -i "$i" -c copy -ss "$START" -sseof 0 CUT_"$i"; }
else
	FFMPEG(){ ffmpeg -y -hide_banner -i "$i" -c copy -ss "$START" -to "${END}.${SUFFIX}" CUT_"$i"; }
fi

for i in *.mp4; do
	DURATION=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal ${i}`
	SUFFIX=${DURATION##*.}
	END=`date -d @$(($(date +%s -d ${DURATION})-${CUTTING})) +"%H:%M:%S"`
	FFMPEG
done
