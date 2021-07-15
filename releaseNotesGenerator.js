// Prerequisites
//
// - JIRA_TOKEN and JIRA_EMAIL should be set in the env
//   https://id.atlassian.com/manage-profile/security > API tokens
//
//   In ~/dotfiles/SUPER_SECRETS_DONT_COMMIT_LOL:
//   export JIRA_TOKEN=abc
//   export JIRA_EMAIL=abc
//
//   In .bashrc or whatever shell:
//   source ~/dotfiles/SUPER_SECRETS_DONT_COMMIT_LOL
//
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

exec('git log --grep="GA-" --pretty=format:"%s" --no-merges --author-date-order origin/master...develop', function(err, log) {
  if (err) { console.log(err); }
  const searched = log.match(/GA(-| )\d+/gi).filter((v, i, a) => a.indexOf(v) === i).filter((v) => v !== 'GA-0');

  let result = '';
  Promise.all(searched.map(id => jira.findIssue(id.replace(' ', '-'))))
    .then(issues => {
      const titles = issues.map(i => i.key ? `- ${i.key} - ${i.fields?.summary}` : null);
      const formatted = titles.filter(Boolean).join('\n');
      result = formatted;
    })
    .catch(() => {})
    .finally(() => {
      process.stdout.write(result);
    });
});
