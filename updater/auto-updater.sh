#!/bin/bash

while true; do 
  sleep 10
  if ! proxychains -q ./get-latest-index.sh; then
    continue
  fi

  if ./patch-index.sh index.*.js; then
    mv index.*.js ../scripts/js/
  fi
done
