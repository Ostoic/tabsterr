#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 index.js"
  exit 1
fi

if [ ! -f $1 ]; then
  echo Error: Unable to find "$1"
  exit 2
fi

function make-patch() {
  num_bytes_before_patch1=$(wc -c $3 | cut -d ' ' -f1)
  if [ $# == 4 ]; then
    sed -i -E "s|$1|$2|g" $3
  else
    sed -i "s|$1|$2|g" $3
  fi

  new_size=$(wc -c $3 | cut -d ' ' -f1)

  if [ $num_bytes_before_patch1 == $new_size ]; then
    echo 'Patch was not applied'
    exit -2
  fi
}

FIND1='const w={app:"Cdy1hg"'
PATCH1='document.getElementById("app").classList.remove("Cdy160");const w={app:"Cdy1hg"'

FIND2='document.getElementById("state").innerHTML'
PATCH2='document.getElementById("state").innerHTML.replaceAll('"'"'"user":{"profile":null,"hasPlus":false,"hasSubscription":false,"isAdmin":false,"isModerator":false,"isLoggedIn":false}'"'"', '"'"'"user":{"profile":null,"hasPlus":true,"hasSubscription":true,"isAdmin":false,"isModerator":false,"isLoggedIn":false}'"'"')'

FIND3='\./([a-zA-Z0-9.]+)'
PATCH3='https://www.songsterr.com/static/latest/\1'

echo "Adding css patch..."
make-patch "$FIND1" "$PATCH1" $1 

echo "Adding js patch..."
make-patch "$FIND2" "$PATCH2" $1 

echo "Adding scripts url patch..."
make-patch "$FIND3" "$PATCH3" $1 exregex

echo "Done!"