#!/bin/bash
if [ -z "$(git diff -- ../../templates)" ]; then
echo '======== help bump up'
node ./scripts/sync-up-version.js yes;
else 
echo '======== self bump up'
node ./scripts/sync-up-version.js 
fi
git add ../../templates