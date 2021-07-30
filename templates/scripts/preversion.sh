#!/bin/bash
echo "=============== $(git diff -- ../packages/test1) ============"
if [ ! -z "$(git diff -- ../packages/test1/package.json)" ]
then 
node ./scripts/sync-up-version.js && git add .
fi