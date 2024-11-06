#!/bin/bash

for file in *.MOV; do
    ffmpeg -i "$file" -vcodec libx264 -acodec aac "${file%.mov}.mp4"
done