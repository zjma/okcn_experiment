#!/bin/bash

# Assume: $OKCNTEST_HTTPD_PREFIX_USER is set.
# Assume: $OKCNTEST_COMMON_INSTALL_PREFIX is set.

OKCNTEST_HTTPD_PREFIX=$OKCNTEST_HTTPD_PREFIX_USER
if [ -z $OKCNTEST_HTTPD_PREFIX ]
then
    OKCNTEST_HTTPD_PREFIX=$OKCNTEST_COMMON_INSTALL_PREFIX/httpd
fi
export OKCNTEST_HTTPD_PREFIX

