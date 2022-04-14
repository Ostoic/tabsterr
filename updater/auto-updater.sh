#!/bin/bash
INDEX_ERR_ALREADY_PATCHED=1
INDEX_ERR_WGET=2
UPDATE_SLEEP_TIME=3600

update-repo() {
  mv index.*.js ../scripts/js/
  git add ..
  git commit -m 'Index update'
  git push
  echo 'New patch committed'
}

if [ ! -f ./get-latest-index.sh ] || [ ! -f ./patch-index.sh ]; then
  echo "Missing patch scripts. Cd to the updater directory from the project root"
  exit -1
fi

echo 'Checking for new index...'
./get-latest-index.sh
index=$?

while true; do
  if [ $index = $INDEX_ERR_WGET ]; then
    echo "Error: wget 404. This means the website structure must have changed in some way"
    exit -1
  elif [ $index -ne $INDEX_ERR_ALREADY_PATCHED ]; then
    echo 'Patching index...'
    if ./patch-index.sh index.*.js; then
      update-repo
    fi
  fi
  
  sleep $UPDATE_SLEEP_TIME
  echo 'Checking for new index...'
  ./get-latest-index.sh
  index=$?
done
