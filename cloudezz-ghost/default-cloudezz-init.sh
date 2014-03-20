#!/bin/sh



GHOST="/cloudezz/ghost"
OVERRIDE="/cloudezz/ghost-override"

CONFIG="config.js"
DATA="content/data"
THEMES="content/themes"

cd "$GHOST"

# Symlink data directory.
mkdir -p "$OVERRIDE/$DATA"
rm -fr "$DATA"
ln -s "$OVERRIDE/$DATA" "content"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

# Symlink themes.
if [[ -d "$OVERRIDE/$THEMES" ]]; then
for theme in $(find "$OVERRIDE/$THEMES" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
  do
rm -fr "$THEMES/$theme"
    ln -s "$OVERRIDE/$THEMES/$theme" "$THEMES/$theme"
  done
fi


#-------------------------------------------------------------------------------
npm config set strict-ssl false
npm config set registry "http://registry.npmjs.org/"
#-------------------------------------------------------------------------------
echo "Executing : forever -e ghost-err.log index.js"
echo "Starting ghost blog service"
forever -e ghost-err.log index.js
#===============================================================================