const fs = require('fs');

process.argv.splice(0,2)

let path= process.argv[0];

let fileContents = fs.readFileSync(path, 'utf8');
let json = JSON.parse(fileContents);

json.scripts.test = 'jest --verbose';
json.scripts["test-coverage"] = 'jest --coverage';
json.scripts["test-watch"] = 'jest --watch';

let jsonText = JSON.stringify(json, null, 2);

fs.writeFileSync(path,jsonText);