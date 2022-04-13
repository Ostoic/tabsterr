#!/bin/bash

INDEX_ERR_ALREADY_PATCHED=1
INDEX_ERR_WGET=2

USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36'
INDEX_URL="https://www.songsterr.com/a/wsa/metallica-fade-to-black-tab-s20"
NEW_INDEX=$(curl -A "$USER_AGENT" -s $INDEX_URL | grep -Eo '(index\.[a-z0-9]+\.js)')
echo $NEW_INDEX

if [ -f ../scripts/js/$NEW_INDEX ]; then
  echo 'Already patched'
  exit $INDEX_ERR_ALREADY_PATCHED
fi

SCRIPTS_URL="https://www.songsterr.com/static/latest"
if ! wget -q "$SCRIPTS_URL/$NEW_INDEX" ; then
  echo 'wget 404 error'
  exit $INDEX_ERR_WGET
fi
