#!/bin/bash
if [[ $_ == $0 ]]; then
  echo "WARNING: this is a subshell"
  echo "  type the following command to correctly set the environment variables."
  echo ""
  echo "  . $(basename $0)"
  echo ""
fi
export WWW_DATA="https://yourserver.com/www.tar.gz"
export Z2_DOWNLOAD_LOCATION="https://yourserver.com/mbtiles/data2.mbtiles"
export Z12_DOWNLOAD_LOCATION="https://yourserver.com/mbtiles/data12.mbtiles"
export Z15_DOWNLOAD_LOCATION="https://yourserver.com/mbtiles/data15.mbtiles"
