const fs = require('fs');
const exec = require('child_process').exec;

let files;
let tweets = [];

exec('ls data/js/tweets', function(err,stdout,stderr) {
  files = stdout.trim().split("\n");
  for (let file of files){
    fs.readFile(`data/js/tweets/${file}`, 'utf-8', function(_, data){
      tweets = tweets.concat(eval(data.slice(31)));

      if (file === files[files.length-1]) {
        const jsonString = JSON.stringify(tweets);

        fs.writeFile('tmp/test.json', jsonString, 'utf-8');
      }
    });
  }
});

