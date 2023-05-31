#!/usr/bin/env ash
#
# Docker start script for developer.gov.uk

source ./spec_args.sh

echo "Runing Dapperdox with specs arguments=[${SPEC_ARGS}]"
DAPPERDOX=${PWD}/dapperdox

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
