console.log(process.env.TESTENV)

// cd /node-red
// git clone $GIT_REPO_URL
// cd $GIT_REPO_NAME
// npm install
// node /node-red/node_modules/node-red/red.js --userDir /node-red/$GIT_REPO_NAME

//var execSync = require('child_process').execSync

var path = require('path');
var fs = require('fs-extra')
var execSync = require('child_process').execSync

if (process.env.GIT_REPOSITORY) {
  var cmd = [
    'cd ' + process.env.HOME,
    'git clone ' + process.env.GIT_REPO_URL,
    'mv ' + path.basename(process.env.GIT_REPO_URL, '.git') + ' .node-red',
    'cd .node-red',
    //'git clone ' + process.env.GIT_SSH + ' && cd $(basename $_ .git) ',
    //'cd ' + path.basename(process.env.GIT_SSH, '.git'),
    'npm install'
  ].join(';')
  
}
