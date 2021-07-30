#!/bin/bash
if [ -z "$(git diff -- ../../templates)" ]; then
node ../../templates/scripts/sync-up-version.js yes;
else 
node ../../templates/scripts/sync-up-version.js 
git add ../../templates
fi