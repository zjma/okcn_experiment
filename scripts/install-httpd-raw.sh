#!bin/bash

# Assume: we are in the httpd root dir.
# Assume: $OKCNTEST_HTTPD_PREFIX is set.
# Assume: $OKCNTEST_SSL_PREFIX is set.
# Assume: openssl has been installed at $OKCNTEST_SSL_PREFIX.

make clean
set -e
cd srclib
rm -rf apr apr-util
ln -s ../../apr apr
ln -s ../../apr-util apr-util
cd ..
./buildconf
./configure --prefix=$OKCNTEST_HTTPD_PREFIX \
            --with-included-apr             \
            --enable-ssl                    \
            --with-ssl=$OKCNTEST_SSL_PREFIX \
            --enable-ssl-staticlib-deps     \
            --enable-mods-static=ssl
make
make install

# Assert: httpd has been installed at $OKCNTEST_HTTPD_PREFIX.

