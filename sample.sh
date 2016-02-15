#!/bin/sh
# slider.sh
# 
#
# Created by andrewws on 10/26/2012.
# 
# Description: Sample Slider Dialog
# set -x  # DEBUG. Display commands and their arguments as they are executed
# set -v  # VERBOSE. Display shell input lines as they are read.
# set -n  # EVALUATE. Check syntax of the script but dont execute


## Variables
#################################################################################################### 
# Variables used for logging
logFile=/private/var/log/newscript.log

# Variables used by this script

# Variables used by Casper

# Variables defined in Casper Admin


## Functions
#################################################################################################### 
# Function 1

## Script
#################################################################################################### 
# Script Action 
CD="/Applications/CocoaDialog.app/Contents/MacOS/CocoaDialog"

filename=`$CD fileselect \
  --title "This is a fileselect"\
    --text "Choose the source file for the main controller" \
    --with-extensions .ll`
if [ -n "$filename" ]; then  ### if $rv has a non-zero length
    echo "Main source: $filename"
else
    echo "No source file selected"
fi

min=`$CD slider --title min --string-output --button1 "set" --min 0 --max 30 --icon gear --always-show-value --debug `
max=`$CD slider --title executable --string-output --button1 "exec" --min 0 --max 30 --icon gear --always-show-value --debug `
# echo "${rv}";
# echo ${rv} | awk -F ' ' '{print $2;}'
min=`echo $min | awk -F' ' '{print $2;}'`
max=`echo $max | awk -F' ' '{print $2;}'`
# echo $a
ruby main.rb -w $min $max $filename


