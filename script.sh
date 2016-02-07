#!/bin/bash

for i in $(cat $1); do 
    name=$(basename $i)
    m3u8_link=$(curl -s $(curl -s $(curl -s $i | \
     grep m3u8  | sed 's/url://' | sed "s/\'//g" | \
      sed "s/,$//g") | sed "s/Moved Temporarily. Redirecting to //") \
    | grep -A 1 1280 | grep -v -e "^#")
    ffmpeg -i $m3u8_link $name.mp4
done
