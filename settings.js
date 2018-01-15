module.exports = {
  httpAdminRoot: '/',
  httpNodeRoot: '/api/',
  uiPort: 3000,
  functionGlobalContext: {
    // os:require('os'),
  },
  adminAuth: {
    type: 'credentials',
    users: [{
      username: process.env.NODE_RED_USERNAME,
      password: process.env.NODE_RED_PASSWORD,
      permissions: '*'
    }]
  },
  debugMaxLength: 1000,
  debugUseColors: true,
  flowFile: 'flows.json',
  userDir: '/node-red/' + process.env.GIT_REPO_NAME,
  ui: { path: 'ui' },
  logging: {
    console: {
      level: 'trace'
    }
  }
}