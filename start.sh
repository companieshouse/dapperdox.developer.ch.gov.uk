#!/bin/bash
#
# Start script for developer.gov.uk

APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -z "${MESOS_SLAVE_PID}" ]]; then
    source ~/.chs_env/private_env
    source ~/.chs_env/global_env
    source ~/.chs_env/dapperdox.developer.ch.gov.uk/env

    PORT="${DAPPERDOX_PORT:=4004}"
else
    PORT="$1"
    CONFIG_URL="$2"
    ENVIRONMENT="$3"
    APP_NAME="$4"

    source /etc/profile

    echo "Downloading environment from: ${CONFIG_URL}/${ENVIRONMENT}/${APP_NAME}"
    wget -O "${APP_DIR}/private_env" "${CONFIG_URL}/${ENVIRONMENT}/private_env"
    wget -O "${APP_DIR}/global_env" "${CONFIG_URL}/${ENVIRONMENT}/global_env"
    wget -O "${APP_DIR}/app_env" "${CONFIG_URL}/${ENVIRONMENT}/${APP_NAME}/env"
    source "${APP_DIR}/private_env"
    source "${APP_DIR}/global_env"
    source "${APP_DIR}/app_env"

    export PATH
fi

source ./spec_args.sh

echo "Runing Dapperdox with specs arguments=[${SPEC_ARGS}]"
DAPPERDOX=${APP_DIR}/dapperdox

${DAPPERDOX}/dapperdox ${SPEC_ARGS} \
    -bind-addr=0.0.0.0:${PORT} \
    -site-url=${DAPPERDOX_DEVELOPER_URL} \
    -default-assets-dir=${DAPPERDOX}/assets \
    -proxy-path=/developer=http://localhost:${CHS_DEVELOPER_MOJO_PORT} \
    -force-specification-list=true \
    -assets-dir=${PWD}/assets \
    -theme-dir=${PWD}/themes/ \
    -theme=dapperdox-theme-gov-uk  \
# additional/future options below as they mess up the multi line command if they are in between non commented lines
#    -log-level=info \
#    -spec-rewrite-url=api.companieshouse.gov.uk=${API_URL} \
#    -author-show-assets=true \
