#!/bin/bash

rm -rf ~/dotfiles/fyodor_output
mkdir ~/dotfiles/fyodor_output

# fyodor /Volumes/Kindle/documents/My\ Clippings.txt ~/dotfiles/fyodor_output
/usr/local/bin/fyodor "/Volumes/Kindle/documents/My Clippings.txt" ~/dotfiles/fyodor_output

last_date=`cat ~/dotfiles/last_kindle_read.txt`

/usr/local/bin/node ~/dotfiles/scrape_highlights.js $last_date

mv ~/dotfiles/new_highlights/* '/Users/rachowicz/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents'

date -u +"%Y-%m-%dT%H:%M:%SZ" > ~/dotfiles/last_kindle_read.txt

