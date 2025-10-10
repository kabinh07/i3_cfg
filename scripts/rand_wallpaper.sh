#!/bin/bash

WALLPAPER_DIR=$HOME/wallpapers
files=("$WALLPAPER_DIR"/*)
count=${#files[@]}
index=$(( RANDOM%count ))
feh --bg-scale "${files[index]}"
