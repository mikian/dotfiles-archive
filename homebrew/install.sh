#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Improve homebrew with taps
taps=( phinze/cask )

# Install following brews
brews=(
ack appledoc exiftool git git-flow graphicsmagick hub mogenerator mongodb mysql node qt rbenv rbenv-default-gems rbenv-gem-rehash rbenv-use
rbenv-whatis redis ruby-build sloccount ssh-copy-id zeromq
brew-cask
)

# Install apps from cask tap
apps=(
anvil arq cloudapp firefox # gfxcardstatus
google-chrome hip-chat i-explorer kaleidoscope lion-disk-maker reveal skype spark-inspector testflight textmate transmit uncrustifyx
versions vmware-fusion
)

# Check for Homebrew
if test ! $(which brew)
then
  echo "  x You should probably install Homebrew first:"
  echo "    https://github.com/mxcl/homebrew/wiki/installation"
  exit
fi

# Install taps
installed_taps=`brew tap`
for tap in ${taps[@]:0}
do
  if [[ ! "$installed_taps" =~ "$tap" ]]
  then
    brew tap $tap
  fi
done

# Install homebrew packages
installed_brews=`brew list`
for brew in ${brews[@]:0}
do
  if [[ ! "$installed_brews" =~ "$brew" ]]
  then
    brew install $brew
  fi
done

installed_apps=`brew cask list`
for app in ${apps[@]:0}
do
  if [[ ! "$installed_apps" =~ "$app" ]]
  then
    brew cask install $app
  fi
done

exit 0