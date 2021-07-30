#!/bin/bash
echo "============ -- $(git diff -- ../../templates)"
echo "------------ == $(git diff --cached ../../templates)"
if [ -z "$(git diff -- ../../templates)" ]; 
then 
node ../../templates/scripts/sync-up-version.js yes; 
git add ../../templates; 
fi