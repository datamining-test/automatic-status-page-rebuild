#!/bin/bash
date +"This is auto github runner at %Y-%m-%d %H:%M:%S" > output.txt
git config --global user.email "automatic@tylerobrien.dev"
git config --global user.name "Auto Rebuild"
git add .
git commit -m "$(date +%s%3N)"
echo Changes made that have to be commited ok
git pull
git push
