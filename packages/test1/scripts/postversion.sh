#!/bin/bash
if [[ -z "$(git tag --points-at HEAD | grep templates)" && ! -z "$(git diff HEAD^ -- ../../templates/package.json|grep version)" ]]
then
    echo "let me tag ==================="
    git tag "templates@$(node -p "require('../../templates/package.json').version")"
fi