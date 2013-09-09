# Only set this if we haven't set $EDITOR up somewhere else previously.
if [[ "$EDITOR" == "" ]] ; then
  # Use sublime for my editor.
  export EDITOR='/usr/local/bin/mate -w'
fi

# Set up languages
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
