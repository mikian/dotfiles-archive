#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  x You should probably install Homebrew first:"
  echo "    https://github.com/mxcl/homebrew/wiki/installation"
  exit
fi

# Install taps
taps = ( phinze/homebrew-cask )

installed = `brew tap`
for tap in ${taps[@]:0}
do
  if [[ "$installed" =~ "$tap" ]]
  then
    echo "$tap: already tapped."
  else
    brew install $tap
  fi
done

# Install homebrew packages
brews=(
ack appledoc exiftool git git-flow graphicsmagick hub mogenerator mongodb mysql node qt rbenv rbenv-default-gems rbenv-gem-rehash rbenv-use
rbenv-whatis redis ruby-build sloccount ssh-copy-id zeromq
brew-cask
)
installed=`brew list`
for brew in ${brews[@]:0}
do
  if [[ "$installed" =~ "$brew" ]]
  then
    echo "$brew: alreadt brewed."
  else
    brew install $brew
  fi
done

apps=(
anvil
arq
cloudapp
firefox
# gfxcardstatus
google-chrome
hip-chat
i-explorer
kaleidoscope
lion-disk-maker
reveal
spark-inspector
testflight
transmit
versions
vmware-fusion
)

installed=`brew cask list`
for app in ${apps[@]:0}
do
  if [[ "$installed" =~ "$app" ]]
  then
    echo "$app: already installed"
  else
    brew cask install $app
  fi
done

exit 0