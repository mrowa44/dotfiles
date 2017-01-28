module.exports = {
  extends: 'airbnb',
  parserOptions: {
    ecmaVersion: 6,
    ecmaFeatures: {
      jsx: true,
    },
  },
  env: {
    browser: true,
    mocha: true,
    node: true,
  },
  settings: {
    ecmascript: 6,
  },
  rules: {
    'no-console': 1,
    'arrow-parens': 1,
  },
};
