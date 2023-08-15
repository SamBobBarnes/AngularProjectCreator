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
    ng new $2 --directory $prefix --routing true --style scss
    npm --prefix $prefix uninstall karma karma-chrome-launcher karma-coverage karma-jasmine karma-jasmine-html-reporter @types/jasmine jasmine-core
    node refactorAngularJson $prefix/angular.json $2
    npm --prefix $prefix i - save-dev jest @types/jest  jest-preset-angular
    echo cat
    cat > $prefix/setup-jest.ts << ENDOFFILE
import 'jest-preset-angular/setup-jest';
ENDOFFILE
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
    npm --prefix $prefix i ts-node
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
  node refactorPackageJson $prefix/package.json
  fi

fi