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
	echo
	echo Installing dependencies...
    npm i
    prefix=$1/$2
	dir=$(pwd)
	echo dir: $dir
	
	echo
    echo Prefex: $prefix
	
	echo
	echo Installing Angular CLI...
    npm i -g @angular/cli
	
	echo
	echo Creating Project...
	cd $1
    ng new $2 --routing true --style scss
	cd $dir
	
	echo
	echo Removing Karma...
    npm --prefix $prefix uninstall karma karma-chrome-launcher karma-coverage karma-jasmine karma-jasmine-html-reporter @types/jasmine jasmine-core
	
	echo
	echo Refactoring Angular.json...
    node refactorAngularJson $prefix/angular.json $2
	
	echo
	echo Installing Jest...
    npm --prefix $prefix i - save-dev jest @types/jest  jest-preset-angular
	
	echo
	echo Setting up Jest...
    cat > $prefix/setup-jest.ts << ENDOFFILE
import 'jest-preset-angular/setup-jest';
ENDOFFILE

	echo
	echo Modifying jest.config.ts...
    cat > $prefix/jest.config.ts << ENDOFFILE
import type {Config} from 'jest';

const config: Config = {
  collectCoverage: true,
  coverageDirectory: "coverage",
  coverageProvider: "v8",
  preset: 'jest-preset-angular',
  setupFilesAfterEnv: ['<rootDir>/setup-jest.ts'],
};

export default config;
ENDOFFILE

	echo
	echo Installing TS-Node...
    npm --prefix $prefix i ts-node
	
	echo
	echo Modifying tsconfig.spec.json...
    cat > $prefix/tsconfig.spec.json << ENDOFFILE
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "./out-tsc/spec",
    "types": [
      "jest" // 1
    ],
    "esModuleInterop": true, // 2
    "emitDecoratorMetadata": true // 3
  },
  "include": [
    "src/**/*.spec.ts",
    "src/**/*.d.ts"
  ]
}
ENDOFFILE

	echo
	echo Refactoring package.json...
  node refactorPackageJson $prefix/package.json
  fi

fi