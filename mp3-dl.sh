#!/bin/bash

# Usage
#    ./mp3-dl.sh "<YouTube URL>"
#    ./mp3-dl.sh "https://www.youtube.com/watch?v=t_5vx21usLE"

set -e -x

# Test command synthax
if [ "$1" = "" ]; then
 echo "./mp3-dl.sh <YouTube URL>"
 exit
fi

# Define variables
URL=$1
# Optional variables; DD="./tmp/" CD="./music" bash ./mp3-dl.sh "https://www.youtube.com/watch?v=t_5vx21usLE"
: ${DD:=/home/admin-srv/tmp/}
: ${CD:=home/admin-srv/owncloud_music/data/loichu/files/Music/}
TMP_MP3=$DD/tmp.mp3

# Test that youtube-dl exists
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
youtube-dl --version >/dev/null 2>&1 || { echo >&2 "I require youtube-dl but it's not installed. Try 'sudo apt install youtube-dl'. Aborting."; exit 1; }
# Extract mp3 from YouTube
youtube-dl -o $TMP_MP3 --extract-audio --audio-format mp3 $URL

# Test that fpcalc exists
fpcalc -version >/dev/null 2>&1 || { echo >&2 "I require fpcalc but it's not installed. Try 'sudo apt install libchromaprint-tools'. Aborting."; rm $DD/*; exit 1; }

# Find fingerprint
fpcalc $TMP_MP3 > $DD/fp.txt
. $DD/fp.txt

# Test variables (from fp.txt)
#echo "duration="$DURATION
#echo "fingerprint="$FINGERPRINT

# get audio description json
curl http://api.acoustid.org/v2/lookup? \
  -d client=ezZaIw4Wm6 \
  -d duration=$DURATION \
  -d fingerprint=$FINGERPRINT \
  -d meta=recordings+releases \
  > $DD/metadatas.json

# test json result
chmod +x $DD/metadatas.json
cat $DD/metadatas.json | jq -r "to_entries|map((.key)=(.value|tostring))|."
# cat ./tmp/metadatas.json
# {"status": "ok", "results": [{"recordings": [{"releases": [{"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "XE"}], "country": "XE", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "d63626b9-a38b-45fc-9157-1d61ac2b2ad5"}, {"track_count": 1, "releaseevents": [{"date": {"month": 10, "day": 23, "year": 2015}, "country": "GB"}], "country": "GB", "title": "Hello", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 10, "day": 23, "year": 2015}, "medium_count": 1, "id": "359720b1-6c37-4aab-87e6-64d7f00e982e"}, {"track_count": 122, "releaseevents": [{"date": {"month": 12, "day": 23, "year": 2015}, "country": "XW"}], "country": "XW", "title": "Best Of 2015 Playlist", "artists": [{"joinphrase": " & ", "id": "35b83b5a-92d9-43d5-9f13-05884257451a", "name": "DJ Creative Mind"}, {"id": "f28992e9-2277-47cd-b203-46cc45beb7ab", "name": "DJ Tati"}], "date": {"month": 12, "day": 23, "year": 2015}, "medium_count": 1, "id": "01b0ca70-0582-4d95-b7b1-03e46c863b55"}, {"track_count": 2, "releaseevents": [{"date": {"month": 10, "year": 2015}, "country": "XE"}], "country": "XE", "title": "Hello", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 10, "year": 2015}, "medium_count": 1, "id": "e0ce7085-808d-4ab5-ab9c-64a1943f3bcb"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "US"}], "country": "US", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "3ce75ee5-4fb0-4209-9bde-8770d17f5fc4"}, {"track_count": 14, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "US"}], "country": "US", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "b2dbd919-229f-41df-a6bf-eaa042c1a550"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "US"}], "country": "US", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "5b78767e-e2b4-4e17-b517-87adfb37210a"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "HK"}], "country": "HK", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "97189482-89ee-4d31-90c7-ba07b412d7f9"}, {"track_count": 14, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "JP"}], "country": "JP", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "89015f5d-d3dc-4ad3-904b-492870bbf4e4"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "JP"}], "country": "JP", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "944d3546-54d2-4baa-9ad3-3f154a21d99b"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "US"}], "country": "US", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "5f74510a-b6f7-4b58-852e-9b9b3a5158d3"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "GB"}], "country": "GB", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "2b4c1e9c-1904-4155-9df6-d1681ddef130"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "JP"}], "country": "JP", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "5bf7da64-1f56-47b6-8604-5067246a03da"}, {"track_count": 11, "releaseevents": [{"date": {"month": 11, "day": 20, "year": 2015}, "country": "US"}], "country": "US", "title": "25", "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "date": {"month": 11, "day": 20, "year": 2015}, "medium_count": 1, "id": "2740ebd0-d6eb-4c9d-9e96-8cc5afb823f5"}], "artists": [{"id": "cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493", "name": "Adele"}], "duration": 295, "title": "Hello", "id": "0a8e8d55-4b83-4f8a-9732-fbb5ded9f344"}, {"releases": [{"track_count": 16, "releaseevents": [{"date": {"month": 8, "day": 14, "year": 2015}, "country": "BR"}, {"date": {"month": 8, "day": 14, "year": 2015}, "country": "US"}], "country": "BR", "title": "Cry Baby", "artists": [{"id": "0df563ec-1a79-486e-a46d-5b9862a40311", "name": "Melanie Martinez"}], "date": {"month": 8, "day": 14, "year": 2015}, "medium_count": 1, "id": "0c467c68-8e33-4187-b338-9ae53f33d8cb"}, {"track_count": 13, "releaseevents": [{"date": {"month": 8, "day": 14, "year": 2015}, "country": "US"}], "country": "US", "title": "Cry Baby", "artists": [{"id": "0df563ec-1a79-486e-a46d-5b9862a40311", "name": "Melanie Martinez"}], "date": {"month": 8, "day": 14, "year": 2015}, "medium_count": 1, "id": "7008942f-58c0-4d86-86e3-0876cc5bf0f1"}], "artists": [{"id": "0df563ec-1a79-486e-a46d-5b9862a40311", "name": "Melanie Martinez"}], "duration": 239, "title": "Cry Baby", "id": "cb3bb9fc-c449-4c52-892b-c189911db710"}], "score": 0.864649, "id": "d5d5ef74-858f-4d84-8121-3910f43693a5"}]}

jq --version >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed. Try 'sudo apt install jq'. Aborting."; rm $DD/*; exit 1; }

# return json variables

# set metadatas in mp3 file

# move file in cloud (/home/admin-srv/Music/Artist/Album/song.mp3)

# delete cache
rm $DD/*
