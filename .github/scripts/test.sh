#!/bin/bash


if [[ "$HELLO" == "hello" && -z '$(git diff --cached)' ]]; then
  echo "Hello foo."
else
  echo "You are not foo."
fi