#!/bin/bash
if [ -z "$DOWNLOAD_URL" ] || [ -z "$DOWNLOAD_TOKEN" ]; then
    echo "Set DOWNLOAD_URL AND DOWNLOAD_TOKEN environment variables!"
    exit 1
fi  
docker run --user root -i -v `pwd`:/home/mapbox/build -t mapbox/gl-native:linux /bin/bash -c "cd ./build/mapbox-gl-native/build/linux-x86_64/Release/;./mbgl-offline -s $DOWNLOAD_URL -t $DOWNLOAD_TOKEN"
