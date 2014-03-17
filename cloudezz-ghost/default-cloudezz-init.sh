#!/bin/sh

cd /cloudezz/ghost
#-------------------------------------------------------------------------------
npm config set strict-ssl false
npm config set registry "http://registry.npmjs.org/"
#-------------------------------------------------------------------------------
echo "Starting ghost blogging service"
NODE_ENV=production forever -o ghost-out.log -e ghost-err.log index.js
#===============================================================================