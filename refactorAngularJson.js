const fs = require('fs');

process.argv.splice(0,2)

let path= process.argv[0];
let project = process.argv[1];

let fileContents = fs.readFileSync(path, 'utf8');
let json = JSON.parse(fileContents);
try {
    delete json.projects[`${project}`].architect['test'];
} catch {

} finally {
    let jsonText = JSON.stringify(json, null, 2);

    fs.writeFileSync(path,jsonText);
}

