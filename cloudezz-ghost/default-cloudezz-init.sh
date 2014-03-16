#!/bin/sh

cd /cloudezz/app
sed -e '0,/host: '"'"'127.0.0.1'"'"'/s//host: '"'"'0.0.0.0'"'"'/' \
config.example.js > config.js
#-------------------------------------------------------------------------------
npm config set strict-ssl false
npm config set registry "http://registry.npmjs.org/"
#-------------------------------------------------------------------------------
echo "Starting ghost blogging service"
forever -o ghost-out.log -e ghost-err.log index.js
#===============================================================================