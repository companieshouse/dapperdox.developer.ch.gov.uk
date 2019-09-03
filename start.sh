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

# Only public spec files should be added to this block
SPEC_ARGS="-spec-dir=${PWD}/specs"
SPEC_ARGS="${SPEC_ARGS} -spec-rewrite-url=http://localhost:3123/swagger-2.0=http://127.0.0.1:${PORT}/api.ch.gov.uk-specifications/swagger-2.0"
SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json" # public streaming api specs


# Pending public spec files should be added to this block
# This should be used for specs that are going to be public but currently not ready to be made publicly available
if [[ "${INCLUDE_PENDING_PUBLIC_SPECS}" -eq "1" ]]; then
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json" # pending public company data api specs
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/filings.json" # pending public filing api specs
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/payments.json" # pending public payment api specs
fi


# Only private/internal spec files should be added to this block
if [[ "${INCLUDE_PRIVATE_SPECS}" -eq "1" ]]; then
    echo "Including private specs"
    SPEC_ARGS="${SPEC_ARGS} -spec-rewrite-url=http://localhost:3123/swagger-2.0-private=http://127.0.0.1:${PORT}/private.api.ch.gov.uk-specifications/swagger-2.0-private"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/chs-kafka-api.json"
fi

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
