#!/bin/bash
if [[ -z "$(git tag --points-at HEAD | grep templates)" && ! -z "$(git diff --cached -- ../../templates)" ]]
then
    echo "=============== templates@$(node -p "require('../../templates/package.json').version")"
    git tag "templates@$(node -p "require('../../templates/package.json').version")"
fi