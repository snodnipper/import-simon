#!/bin/bash
if [[ $_ == $0 ]]; then
  echo "WARNING: this is a subshell"
  echo "  type the following command to correctly set the environment variables."
  echo ""
  echo "  . env.sh"
  echo ""
fi
export Z12_DOWNLOAD_LOCATION="https://yourserver.com/data_Z12.mbtiles"
export Z15_DOWNLOAD_LOCATION="https://yourserver.com/data_Z15.mbtiles"


