// Prerequisites
//
// - JIRA_TOKEN and JIRA_EMAIL should be set in the env
// - npm install jira-client
// 
// Run:
//    node ~/releaseNotesGenerator.js
//
// in the desired repo dir to generate notes
//
// Or create a shell alias
//    alias generate_release_notes="node ~/releaseNotesGenerator.js"
//
const { exec } = require('child_process');
const JiraApi = require('jira-client');

const { JIRA_TOKEN, JIRA_EMAIL } = process.env;

const jira = new JiraApi({
  protocol: 'https',
  host: 'gabi-com.atlassian.net',
  username: JIRA_EMAIL,
  password: JIRA_TOKEN,
  apiVersion: '2',
  strictSSL: true,
});

exec('git log --grep="GA-" --pretty=format:"%s" --no-merges --author-date-order master...develop', function(err, log) {
  const searched = log.match(/GA-\d+/gi).filter((v, i, a) => a.indexOf(v) === i);

  Promise.all(searched.map(id => jira.findIssue(id)))
    .then(issues => {
      const titles = issues.map(i => `${i.fields.summary} - ${i.key}`);
      process.stdout.write(titles.join('\n'));
    });
});
