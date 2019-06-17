const fs = require('fs');
const path = require('path');
const process = require('child_process');

const exists = (path) => {
  return fs.existsSync(path) || path.existsSync(path);
}

const isDir = (path) => {
  return exists(path) && fs.statSync(path).isDirectory();
}

const includeFile = (folder, filename) => {
  const files = fs.readdirSync(folder);
  return files.includes(filename);
}

const flutter_project_folders = [];

const get_flutter_project_folders = (folder) => {
  const files = fs.readdirSync(folder);
  files.forEach(file => {
    if (isDir(file)) {
      const absolutePath = path.join(__dirname, file)
      if (includeFile(absolutePath, 'pubspec.yaml')) {
        flutter_project_folders.push(absolutePath);
      }
    }
  });
}

const get_flutter_project_packages = (projectPath) => {
  console.log(`${projectPath} get packages start...`);
  return new Promise((resolve, reject) => {
    process.exec(`cd ${projectPath} && flutter packages get`, function (error, stdout, stderr) {
      if (error !== null) {
        console.log('exec error: ' + error);
        resolve(error);
      } else {
        console.log(stdout);
        if (stderr !== '') {
          console.log(stderr);
        }
        resolve();
      }
    });
  });
}

const main = () => {
  const start = Date.now();
  get_flutter_project_folders('./');
  Promise.all(flutter_project_folders.map(get_flutter_project_packages))
    .then(() => {
      const end = Date.now();
      console.log(`All project get flutter packages in ${(end - start) / 1000} seconds`);
    })
}

main();
