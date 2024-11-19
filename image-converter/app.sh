#!/bin/bash

INPUT_FORMAT=$1
OUTPUT_FORMAT=$2

print_help() {
    echo -e "Usage\tapp.sh <input_format> <output_format> <work-directory>"
    echo -e "\tExample: app.sh MKV mp4"
    echo -e "help\tprint this help script"
}

file_convertion() {
    local FROM_FORMAT=$1
    local TO_FORMAT=$2

    OUTPUT_SUB_DIR="converted-$FROM_FORMAT-$TO_FORMAT"
    echo "$OUTPUT_SUB_DIR"
    mkdir $OUTPUT_SUB_DIR
    
    for file in *."$FROM_FORMAT"; do
        # Check if the file exists
        if [ -f "$file" ]; then
            START_TIME=$(date +%s)
            echo -e -n "Processing $file"
            # Remove the file extension and add the new one
            mogrify -format $TO_FORMAT "$file"
            
            END_TIME=$(date +%s)

            FILE_SIZE=$(stat -c %s "$file")
            # Calculate the elapsed time in seconds
            ELAPSED_TIME=$((END_TIME - START_TIME))
            # Optional: Print the elapsed time
            echo -e -n "\t$ELAPSED_TIME s"
            # file size
            FILE_SIZE_KB=$(echo "scale=2; $FILE_SIZE / 1024" | bc)
            echo -e -n "\t$FILE_SIZE_KB kb"

            # Calculate the processing speed in KB per second
            PROCESSING_SPEED=$(echo "scale=2; $FILE_SIZE_KB / $ELAPSED_TIME" | bc)
            echo -e "\t$PROCESSING_SPEED kbps"
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
# echo $3
# echo $WORK_DIRECTORY
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

# mogrify -format jpg *.HEIC