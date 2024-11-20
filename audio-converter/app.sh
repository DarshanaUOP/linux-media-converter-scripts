#!/bin/bash

for file in *.m4a; do
    if [ -f "$file" ]; then
        # Extract the base name (without extension)
        base="${file%.m4a}"
        # Convert to MP4
        ffmpeg -i "$file" -c copy "${base}.mp4"
        echo "Converted: $file -> ${base}.mp4"
    fi
done
