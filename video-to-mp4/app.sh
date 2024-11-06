#!/bin/bash

INPUT_FORMAT=$1
OUTPUT_FORMAT=$2

print_help() {
    echo -e "Usage\tapp.sh <input_format> <output_format>"
    echo -e "\tExample: app.sh MKV mp4"
    echo -e "help\tprint this help script"
}

file_convertion() {
    local FROM_FORMAT=$1
    local TO_FORMAT=$2

    $OUTPUT_SUB_DIR = "converted-$FROM_FORMAT-$TO_FORMAT" 
    echo "$OUTPUT_SUB_DIR"

    for file in *."$FROM_FORMAT"; do
        # Check if the file exists
        if [ -f "$file" ]; then
            echo "Processing $file"
            # Remove the file extension and add the new one
            ffmpeg -i "$file" -vcodec libx264 -acodec aac "${file%.$FROM_FORMAT}.$TO_FORMAT"
        else
            echo "No files with .$FROM_FORMAT extension found"
        fi
    done
}

if [ -z "$3" ]; then 
    WORK_DIRECTORY="."
else
    WORK_DIRECTORY=$3
fi
echo $3
echo $WORK_DIRECTORY
# Change directory
cd $WORK_DIRECTORY
pwd

if [ -z "$INPUT_FORMAT" ]; then
    if [ -z "$OUTPUT_FORMAT" ]; then
        # both parameters are empty
        print_help
        exit 0
    fi
fi 

if [ "$INPUT_FORMAT" = "help" ]; then
    print_help
    exit 0
fi

if [ -n "$INPUT_FORMAT" ] && [ -n "$OUTPUT_FORMAT" ]; then
    file_convertion $INPUT_FORMAT $OUTPUT_FORMAT
fi

# for file in *.MOV; do
#     ffmpeg -i "$file" -vcodec libx264 -acodec aac "${file%.mov}.mp4"
# done
