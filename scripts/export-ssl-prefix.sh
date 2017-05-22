#!/bin/bash

# Assume: $OKCNTEST_SSL_PREFIX_USER is set.
# Assume: $OKCNTEST_COMMON_INSTALL_PREFIX is set.

OKCNTEST_SSL_PREFIX=$OKCNTEST_SSL_PREFIX_USER
if [ -z $OKCNTEST_SSL_PREFIX ]
then
    OKCNTEST_SSL_PREFIX=$OKCNTEST_COMMON_INSTALL_PREFIX/ssl
fi
export OKCNTEST_SSL_PREFIX
