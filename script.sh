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
    prefix=$1/$2
    echo $prefix
    npm i -g @angular/cli
    ng new $2 --directory $prefix
    npm --prefix $prefix uninstall karma karma-chrome-launcher karma-coverage karma-jasmine karma-jasmine-html-reporter @types/jasmine jasmine-core
#TODO: remove test object from angular.json
    npm --prefix $prefix i - save-dev jest @types/jest  jest-preset-angular
    echo cat
    cat > $prefix/setup-jest.ts << ENDOFFILE
import 'jest-preset-angular/setup-jest';
ENDOFFILE
    echo jest init
    npm --prefix $prefix exec jest --init
#TODO: Set preset and setupfilesAfterEnv in jest.config.ts
    echo ts-node
    npm --prefix $prefix i ts-node
#TODO: Update tsconfig.spec.json
#TODO: Update package.json
  fi

fi