#!/bin/bash


# if [[ "$HELLO" == "hello" && ! -z '$(git diff --cached)' ]]; then
#   echo "Hello foo."
# else
#   echo "You are not foo."
# fi

# var=${git diff --cached}
touch a.txt 
git add .

if [[ ! -z "$(git diff --cached)" ]]
then 
    echo 'hello'
fi