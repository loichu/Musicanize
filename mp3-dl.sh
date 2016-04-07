#!/bin/bash

if [ "$1" = "" ]; then
 echo "./mp3-dl.sh <YouTube URL>"
 exit
fi

URL=$1
DD=/home/admin-srv/tmp/tmp.mp3
CD=/home/admin-srv/owncloud_music/data/loichu/files/Music

youtube-dl -o $DD --extract-audio --audio-format mp3 $URL

# Ici fingerpring
fpcalc $DD > /home/admin-srv/tmp/fp.txt
. fp.txt

# get audio description json
wget http://api.acoustid.org/v2/lookup? & client=ezZaIw4Wm6 & duration=$DURATION & fingerprint=$FINGERPRINT & meta=recordings+releases > /home/admin-srv/tmp/metadatas.json

rm /home/admin-srv/tmp/*
# rename and  move current.mp3 /home/dossierparageOwnCloud/Auteur/Album/titre.mp3
