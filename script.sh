#!/bin/bash

if [ -z "$1" ]
then
  echo A path to install folder is required!
  echo Run \"./script.sh [PATH] [NAME]\"
  echo Example \"./script.sh ./path/to/containing/folder project-name\"
  exit 1
else

  if [ -z "$2" ]
  then
    echo A project name is required!
    echo Run "./script.sh [PATH] [NAME]"
  echo Example "./script.sh ./path/to/containing/folder project-name"
    exit 1

  else
    cd $1
  #  npm i -g @angular/cli
    ng new $2
  fi

fi