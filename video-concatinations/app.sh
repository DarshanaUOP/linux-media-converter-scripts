#!/bin/bash

for f in *.MOV; do echo "file '$f'" >> videos.txt; done
ffmpeg -f concat -safe 0 -i videos.txt -c:v libx264 -c:a aac -strict experimental output.mp4
rm videos.txt