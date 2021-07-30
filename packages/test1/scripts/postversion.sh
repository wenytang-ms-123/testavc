#!/bin/bash
if [[ -z \"$(git tag --points-at HEAD | grep templates)\" && ! -z \"$(git diff -- ../../templates)\" ]]
then
    git tag "templates@$(node -p "require('../../templates/package.json').version")"
fi