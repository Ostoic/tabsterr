#!/bin/bash

INDEX_URL="https://www.songsterr.com/a/wsa/metallica-fade-to-black-tab-s20"
NEW_INDEX=$(curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36' -s $INDEX_URL | grep -Eo '(index\.[a-z0-9]+\.js)')

if [ -f ../scripts/js/$NEW_INDEX ]; then
  echo 'Already patched'
  exit -1
fi

SCRIPTS_URL="https://www.songsterr.com/static"

wget -q "$SCRIPTS_URL/$NEW_INDEX"