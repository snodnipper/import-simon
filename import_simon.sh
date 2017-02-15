#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

# arg1: download URL
# arg2: output directory 
explode () {
    URL=$1
    if [ -z "$URL" ]; then
        warning "Download URL parameter is required!  This is the URL to download an MBTiles file"
        exit 1
    fi
    DIRECTORY=$2
    if [ -z "$DIRECTORY" ]; then
        warning "Output directory required!"
        exit 1
    fi

    OUTPUT_FILE=$(download $URL)
    OUTPUT_UNPACKED=""
    if [ ! -d $DIRECTORY ]; then
        OUTPUT_UNPACKED=$(unpack $OUTPUT_FILE)
        if [ ! -d $OUTPUT_UNPACKED ]; then
            warning "problem unpacking data!"
            exit 1
        fi
        mv $OUTPUT_UNPACKED $DIRECTORY
    else
        warning "$DIRECTORY exists - not unpacking!"
    fi
}

# arg1: download URL
download () {
    URL=$1
    if [ -z "$URL" ]; then
        warning "Download URL parameter is required!  This is the URL to download an MBTiles file"
        exit 1
    fi

    FILENAME="${URL##*/}"

    # Download if file not already there
    if [ ! -f $FILENAME ]; then
        wget $URL
    else
        warning "$FILENAME already there...skipping download."
    fi

    if [ -z "$FILENAME" ]; then
        warning "ERROR - cannot get filename for download"
        exit 1
    fi

    echo $FILENAME
}

# arg1: the mbtiles filename to unpack
# echo location of unpacked data
# Dev note: we redirect output because this function must only echo a single response
unpack () {
    FILENAME=$1
    OUTPUT_FILENAME=output_$FILENAME
    if [ ! -d $OUTPUT_FILENAME ]; then
        warning "Unpacking.  This might take a while..."
        mb-util --image_format=pbf $FILENAME $OUTPUT_FILENAME > /dev/null 2>&1
        
        if [ ! -d $OUTPUT_FILENAME ]; then
            warning "aborting - could not unpack $OUTPUT_FILENAME"
            exit 1
        fi
        
        warning "adding pbf extension.  This might take a while..."
        find ./$OUTPUT_FILENAME -type f | grep -v json$ | xargs -I{} mv '{}' '{}.pbf' > /dev/null 2>&1
        gzip -d -r -S .pbf ./$OUTPUT_FILENAME/* > /dev/null 2>&1
    else
        warning "'$OUTPUT_FILENAME' appears to be unpacked - ignoring!"
    fi
    echo $OUTPUT_FILENAME
}

warning() {
    >&2 echo $1
}

#################
# Demo map data is available in buckets named z12 and z15.
# Note: z12 is just a name (it could have any number of zoom levels)
# 
# Requires:
# > Z12_DOWNLOAD_LOCATION - e.g. "https://your-domain.com/app_Z12_0_1.mbtiles"
# > Z15_DOWNLOAD_LOCATION - e.g. "https://your-domain.com/app_Z15_0_7.mbtiles"
#################
echo Starting Workflow

echo Executing Z12
explode $Z12_DOWNLOAD_LOCATION z12
echo Executing Z15
explode $Z15_DOWNLOAD_LOCATION z15
