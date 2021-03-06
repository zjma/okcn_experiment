#!/bin/bash

function print_usage {
    printf "\nUsage: ./setup-client.sh [install-dir=/tmp]\n\n"
}

if [ -z $1 ]
then
    print_usage
    exit 0
fi

export OKCNTEST_ROOT_DIR=$PWD
export OKCNTEST_SCRIPTS_DIR=$OKCNTEST_ROOT_DIR/scripts

export OKCNTEST_SSL_PREFIX_USER=
export OKCNTEST_HTTPD_PREFIX_USER=
export OKCNTEST_HTTPLOAD_PREFIX_USER=
export OKCNTEST_COMMON_INSTALL_PREFIX=$1

source $OKCNTEST_SCRIPTS_DIR/export-common-prefix.sh

source $OKCNTEST_SCRIPTS_DIR/export-ssl-prefix.sh

source $OKCNTEST_SCRIPTS_DIR/export-httpload-prefix.sh

source $OKCNTEST_SCRIPTS_DIR/export-httpd-prefix.sh

cd $OKCNTEST_ROOT_DIR/openssl
bash $OKCNTEST_SCRIPTS_DIR/install-openssl-raw.sh || exit 1

cd $OKCNTEST_ROOT_DIR/http_load
bash $OKCNTEST_SCRIPTS_DIR/install-httpload-raw.sh || exit 1

printf "\nClient side ready.\n\n"

