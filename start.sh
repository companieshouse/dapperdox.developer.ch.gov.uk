#!/bin/bash
#
# Start script for developer.gov.uk

APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -z "${MESOS_SLAVE_PID}" ]]; then
    source ~/.chs_env/private_env
    source ~/.chs_env/global_env
    source ~/.chs_env/developer.gov.uk/env

    PORT="${CHS_CH_PORT:=3000}"
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

DAPPERDOX=${APP_DIR}/dapperdox

${DAPPERDOX}/dapperdox \
    -spec-dir=${APP_DIR}/specs/api.ch.gov.uk-specifications/swagger-2.0 \
    -spec-filename=spec/swagger.json \
    -spec-filename=spec/filings.json \
    -spec-filename=spec/streaming.json \
    -spec-filename=spec/payments.json \
    -bind-addr=0.0.0.0:${PORT} \
    -site-url=${DAPPERDOX_DEVELOPER_URL} \
    -default-assets-dir=${DAPPERDOX}/assets \
    -theme-dir=${APPDIR}/themes/ \
    -theme=dapperdox-theme-gov-uk  \
    -log-level=info \
    -force-specification-list=true \
    -spec-rewrite-url=http://localhost:3123/swagger-2.0 \
    -spec-rewrite-url=localhost:4003=http://localhost:4005 \
    -spec-rewrite-url=api.companieshouse.gov.uk=chs-dev:4001 \
    -document-rewrite-url=http://localhost:4003=http://localhost:4005 \
    -assets-dir=${APP_DIR}/assets \
    #-author-show-assets=true \
    #-proxy-path=/developer=http://localhost:4006 \
    #-tls-key=server.rsa.key \
    #-assets-dir=./examples/overlay/assets \
   # -spec-dir=examples/specifications/petstore/ \
