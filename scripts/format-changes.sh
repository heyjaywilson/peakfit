#!/usr/bin/env sh

git diff --diff-filter=d --staged --name-only | grep -e '\(.*\).swift$' | while read line; do
    swift-format format --configuration .swift-format.json -i "${line}";
    git add "$line";
done