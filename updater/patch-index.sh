#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 index.js"
  exit -1
fi

FIND1='";var w={app:"Cdy1hg"'
FIND2='await Promise.resolve(),b(i(I.Provider,{value:t}'
PATCH1='";document.getElementById("app").classList.remove("Cdy160");var w={app:"Cdy1hg"'
PATCH2='(t.state.user={profile:null,hasPlus:true,hasSubscription:true,isAdmin:false,isModerator:false,isLoggedIn:false}, await Promise.resolve()),b(i(I.Provider,{value:t}'

# Make first patch
echo "Adding css patch..."
num_bytes_before_patch1=$(wc -c $1 | cut -d ' ' -f1)
sed -i "s|$FIND1|$PATCH1|g" $1
new_size=$(wc -c $1 | cut -d ' ' -f1)

if [ $num_bytes_before_patch1 == $new_size ]; then
  echo 'Patch 1 was not applied'
  exit -2
fi

echo "Adding js patch..."
num_bytes_before_patch1=$(wc -c $1 | cut -d ' ' -f1)
sed -i "s|$FIND2|$PATCH2|g" $1
new_size=$(wc -c $1 | cut -d ' ' -f1)

if [ $num_bytes_before_patch1 == $new_size ]; then
  echo 'Patch 2 was not applied'
  exit -3
fi

echo "Done!"
