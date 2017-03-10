#!/bin/bash

# Build container to clone repository
echo "Build the repo cloner Container"
docker build -t mapbox-docker .

echo We are here $(pwd)
# Clone or update, depending if it is there
if [ ! -d mapbox-gl-native ]; then
   echo "Execute clone"
   docker run -v $(pwd):/root mapbox-docker /usr/bin/git clone https://github.com/mapbox/mapbox-gl-native.git
else
   echo "Execute update"
   docker run -v $(pwd):/root mapbox-docker /bin/bash -c "cd mapbox-gl-native;/usr/bin/git pull"
fi

username=$(id -un)
group=$(id -gn)
chown -R $username:$group mapbox-gl-native
