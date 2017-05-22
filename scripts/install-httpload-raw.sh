#!bin/bash

# Assume: we are in the httpload root dir.
# Assume: $OKCNTEST_HTTPLOAD_PREFIX is set.
# Assume: $OKCNTEST_SSL_PREFIX is set.
# Assume: openssl has been installed at $OKCNTEST_SSL_PREFIX.

make clean
set -e
autoreconf --install
./configure --prefix=$OKCNTEST_HTTPLOAD_PREFIX --with-ssl=$OKCNTEST_SSL_PREFIX
make
make install

