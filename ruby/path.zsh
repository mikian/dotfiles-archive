export RBENV_ROOT=/usr/local/var/rbenv
export CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl` --without-tcl --without-tk"
export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
