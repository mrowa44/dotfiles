const path = require('path');
const fs = require('fs');
const isAfter = require('date-fns/isAfter');

const directoryPath = path.join(__dirname, '/fyodor_output');
const dateRegex = /\w+, \d+ \w+ \d+ \d+:\d+:\d+/;

function outputItems(items, bookName) {
  const allData = items.map(i => i.text).join('\n\n');
  const allOutputPath = path.join(__dirname, `/all_highlights/${bookName}.txt`);
  fs.writeFile(allOutputPath, allData, (err) => {
  });

  const arg = process.argv.slice(2);
  const since = arg[0];
  const newHighlights = items.filter(item => {
    return isAfter(new Date(item.date), new Date(since));
  });
  if (newHighlights.length > 0) {
    const data = newHighlights.map(i => i.text).join('\n\n');
    const outputPath = path.join(__dirname, `/new_highlights/${bookName}.txt`);
    fs.writeFile(outputPath, data, (err) => {
    });
  }
}

function parseFile(text, bookName) {
  const splitted = text.split('\n');
  const dateAndText = splitted.filter(i => i !== '');
  const highlights = dateAndText.reduce((result, current, idx) => {
    const date = current.match(dateRegex);
    const dateMatch = date && date[0];
    const prev = idx !== 0 && dateAndText[idx - 1].replace('*', '').trim();
    if (dateMatch && !prev.startsWith('loc')) {
      result.push({
        date: dateMatch,
        text: prev,
      });
      return result;
    } else {
      return result;
    }
  }, []);

  outputItems(highlights, bookName);
}

function readFile(file) {
  const filePath = path.join(__dirname, `/fyodor_output/${file}`);
  fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
    if (!err) {
      parseFile(data, file);
    } else {
      console.log(err);
    }
  });
}

fs.readdir(directoryPath, function (err, files) {
  if (err) { return console.log('Unable to scan directory: ' + err); }

  files.forEach(function (file) {
    readFile(file);
  });
  console.log('%c scrape_highlights', 'color: blue; font-weight: bold;', 'ok');
});
