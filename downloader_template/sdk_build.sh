#!/bin/bash

echo Building Mapbox SDK Docker containers
echo $(pwd)
cd mapbox-gl-native
./docker/build.sh
./docker/linux/run.sh
