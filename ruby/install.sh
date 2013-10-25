#!/bin/sh
#
# rbenv-default-gems
#
# Set up rbenv default gems

if test ! -d /usr/local/var/rbenv/;
then
  mkdir -p /usr/local/var/rbenv/
fi

(
cat <<'EOF'
bundler
pry
EOF
) > /usr/local/var/rbenv/default-gems
