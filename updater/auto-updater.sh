#!/bin/bash

if [ ! -f ./get-latest-index.sh ] || [ ! -f ./patch-index.sh ]; then
  echo "Missing patch scripts. Cd to the updater directory from the project root"
  exit -1
fi

while true; do 
  sleep 3600
  echo 'Checking for new index...'
  if ! ./get-latest-index.sh; then
    continue
  fi

  echo 'Patching index...'
  if ./patch-index.sh index.*.js; then
    mv index.*.js ../scripts/js/
    git add ..
    git commit -m 'Index update'
    git push
    echo 'New patch committed'
  fi
done
