#!/usr/bin/env bash

#Rotate wallpapers
#Sepends on wallpaper-cli to change wallpaper https://github.com/sindresorhus/wallpaper-cli

#Sample use:
# ./random-wallpaper.sh ~/Pictures/wallpapers



function random_file_in_dir(){
  local wallpaper_dir=$1

  #didn't get a directory? default to ~/Pictures
  if [ -z "$wallpaper_dir" ] ; then wallpaper_dir=$HOME/Pictures ;  fi

  #Directory is empty? Nothing to do
  if [ $(ls -1qA  $wallpaper_dir | wc -l) -lt 1 ] ; then return ""; fi

  #return random file
  echo $(find $wallpaper_dir -maxdepth 1 -type f | shuf -n 1)

}

#------------------------
#Main
random_wallpaper_file=$(random_file_in_dir $1)
wallpaper $random_wallpaper_file
