#!/bin/bash


# if [[ "$HELLO" == "hello" && ! -z '$(git diff --cached)' ]]; then
#   echo "Hello foo."
# else
#   echo "You are not foo."
# fi

# var=${git diff --cached}
# touch a.txt
#           git add .
#           if [[ '${{github.event.inputs.preid}}' == "stable" && ! -z "$(git diff --cached)" ]]; then
#             echo "heheh"
#           fi

echo $(git diff -- ./templates)
if [ -z "$(git diff -- ./templates)" ]; then 
  node ./packages/test1/scripts/sync-up-version.js
fi