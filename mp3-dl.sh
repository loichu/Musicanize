#!/bin/bash

# Test command synthax 
if [ "$1" = "" ]; then
 echo "./mp3-dl.sh <YouTube URL>"
 exit
fi

# Define variables
URL=$1
DD=/home/admin-srv/tmp/
CD=/home/admin-srv/owncloud_music/data/loichu/files/Music

# Extract mp3 from YouTube
youtube-dl -o $DD --extract-audio --audio-format mp3 $URL

# Find fingerprint
fpcalc $DD > /home/admin-srv/tmp/fp.txt
. fp.txt

# Test variables (from fp.txt)
echo "duration="$DURATION
echo "fingerprint="$FINGERPRINT

# get audio description json
curl -F "client=ezZaIw4Wm6;duration=$DURATION;fingerprint=$FINGERPRINT;meta=recordings+releases" http://api.acoustid.org/v2/lookup? > /home/admin-srv/tmp/metadatas.json

# test json result
echo /home/admin-srv/tmp/metadatas.json

# return json variables

# set metadatas in mp3 file

# move file in cloud (/home/admin-srv/Music/Artist/Album/song.mp3)

# delete cache
rm /home/admin-srv/tmp/*
