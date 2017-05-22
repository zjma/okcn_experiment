#!bin/bash

# Assume: we are in the openssl root dir.
# Assume: $OKCNTEST_SSL_PREFIX is set.

make clean
set -e
./config --prefix=$OKCNTEST_SSL_PREFIX
make depend
make
make install_sw

# Assert: openssl has been installed at $OKCNTEST_SSL_PREFIX.

