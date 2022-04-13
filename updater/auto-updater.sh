#!/bin/bash

update-repo() {
  mv index.*.js ../scripts/js/
  git add ..
  git commit -m 'Index update'
  git push
  echo 'New patch committed'
}

check-latest-index() {
  echo 'Checking for new index...'
  if ! ./get-latest-index.sh; then
    return 1
  fi
}

if [ ! -f ./get-latest-index.sh ] || [ ! -f ./patch-index.sh ]; then
  echo "Missing patch scripts. Cd to the updater directory from the project root"
  exit -1
fi

check-latest-index
while true; do
  echo 'Patching index...'
  if ./patch-index.sh index.*.js; then
    update-repo
  fi
  
  sleep 3600
  check-latest-index
done
