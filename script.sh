#!/bin/bash

echo $0

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
#    ng new $2
    cd $2
    ls
    npm uninstall karma karma-chrome-launcher karma-coverage karma-jasmine karma-jasmine-html-reporter @types/jasmine jasmine-core
    #TODO: remove test object from angular.json
    npm i - save-dev jest @types/jest  jest-preset-angular
    echo import 'jest-preset-angular/setup-jest'; > setup-jest.ts
    npx jest --init
    npm i ts-node
  fi

fi