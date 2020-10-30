#!/bin/bash

file=$HOME/chrome-version.txt

echo "" >> $file

date -Iseconds >> $file

aptitude versions google-chrome-stable >> $file

echo "--------------------" >> $file

tail $file

grep -C 2 google-chrome-stable /var/log/apt/history.log
