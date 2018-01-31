#!/bin/bash

# cd /node-red
# git clone $GIT_REPO_URL
# cd $GIT_REPO_NAME
# npm install
# node /node-red/node_modules/node-red/red.js --userDir /node-red/$GIT_REPO_NAME

# exists ${GIT_REPO_URL}
if [ -n "${GIT_REPO_URL}" ]; then
  cd ${HOME}
  git clone ${GIT_REPO_URL}
  mv $(basename ${GIT_REPO_URL} .git) .node-red
  cd ${HOME}/.node-red
  npm install
  # exists settings.js
  if [ ! -e "${HOME}/.node-red/settings.js" ]; then
    echo 'module.exports = {' > settings.js
    echo '  uiPort: process.env.PORT || 1880,' >> settings.js
    echo '  mqttReconnectTime: 15000,' >> settings.js
    echo '  serialReconnectTime: 15000,' >> settings.js
    echo '  debugMaxLength: 1000,' >> settings.js
    echo '  debugUseColors: true,' >> settings.js
    echo '  flowFile: "'${NODE_RED_FLOWS_FILENAME}'",' >> settings.js
    echo '  flowFilePretty: false,' >> settings.js
    # exists ${NODE_RED_USERNAME}
    if [ -n "${NODE_RED_USERNAME}" ]; then
      echo '  adminAuth: {' >> settings.js
      echo '    type: "credentials",' >> settings.js
      echo '    users: [{' >> settings.js
      echo '      username: "'${NODE_RED_USERNAME}'",' >> settings.js
      echo '      password: "'${NODE_RED_PASSWORD}'",' >> settings.js
      echo '      permissions: "*"' >> settings.js
      echo '    }]' >> settings.js
      echo '  },' >> settings.js
    fi
    echo '  functionGlobalContext: {' >> settings.js
    echo '  },' >> settings.js
    echo '  logging: {' >> settings.js
    echo '    console: {' >> settings.js
    echo '      level: "info",' >> settings.js
    echo '      metrics: false,' >> settings.js
    echo '      audit: false' >> settings.js
    echo '    }' >> settings.js
    echo '  }' >> settings.js
    echo '}' >> settings.js
  fi
fi
