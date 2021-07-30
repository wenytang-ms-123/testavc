#!/bin/bash
if [[ -z "$(git tag --points-at HEAD | grep templates)" && ! -z "$(git diff ^HEAD -- ../../templates/package.json|grep version)" ]]
then
    echo "=============== templates@$(node -p "require('../../templates/package.json').version")"
    git tag "templates@$(node -p "require('../../templates/package.json').version")"
fi