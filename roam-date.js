const Sugar = require('sugar-date');

function formatDate(input) {
  const date = new Sugar.Date(input).format('{Month} {do}, {year}');
  return `[[${date.raw}]]`;
}

function getDays(query) {
  const queryNum = Number(query);
  const daysNum = Math.abs(queryNum);
  const daysMap = [...Array(daysNum).keys()].map(i => i + 1);
  if (queryNum > 0) {
    return daysMap.map((inDays) => {
      return formatDate(`in ${inDays} days`);
    });
  } else {
    return daysMap.map((daysAgo) => {
      return formatDate(`${daysAgo} days ago`);
    });
  }
}

const arg = process.argv.slice(2);
const command = arg[0];
const input = arg[1];

if (command === '-d') {
  const date = formatDate(input);
  process.stdout.write(date);
}
if (command === '-l') {
  const days = getDays(input);
  const result = days.join('\n');
  process.stdout.write(result);
}
