module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 12,
    fontFamily: 'SF Mono, Menlo, monospace',
    cursorShape: 'BLOCK',
    shell: '/bin/zsh',
    bell: false,
    copyOnSelect: false,
    env: {
      LC_ALL: 'en_US.UTF-8',
    },
  },
  plugins: [
    'hyper-snazzy',
    // 'hyperterm-duotone-dark',
    'hyper-hide-title',
    'hyperterm-close-on-left',
    'hyper-confirm',
    'hyper-quit',
    'hyper-search',
    'hyperlinks',
    'hyperterm-alternatescroll',
    'hyperterm-paste',
    'hypercwd',
  ],
};
