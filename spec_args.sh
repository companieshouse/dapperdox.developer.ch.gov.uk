#!/usr/bin/env sh
# Only public spec files should be added to this block
SPEC_ARGS="-spec-dir=${PWD}/specs"
SPEC_ARGS="${SPEC_ARGS} -spec-rewrite-url=http://localhost:3123/swagger-2.0=http://127.0.0.1:${PORT}/api.ch.gov.uk-specifications/swagger-2.0"
SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json" # public streaming api specs


# Pending public spec files for API Filing initial release
if [[ "${INCLUDE_API_FILING_PUBLIC_SPECS}" -eq "1" ]]; then
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=document.api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=account.ch.gov.uk-specifications/swagger-2.0/identity-public.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/filings-public.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/testDataGenerator.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/pscDiscrepancies.json"
fi

# Pending public spec files should be added to this block
# This should be used for specs that are going to be public but currently not ready to be made publicly available
if [[ "${INCLUDE_PENDING_PUBLIC_SPECS}" -eq "1" ]]; then
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/payments.json" # pending public payment api specs
fi


# Only private/internal spec files should be added to this block
if [[ "${INCLUDE_PRIVATE_SPECS}" -eq "1" ]]; then
    echo "Including private specs"
    SPEC_ARGS="${SPEC_ARGS} -spec-rewrite-url=http://localhost:3123/swagger-2.0-private=http://127.0.0.1:${PORT}/private.api.ch.gov.uk-specifications/swagger-2.0-private"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/filings.json" # private filing api specs
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/chs-kafka-api.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=api.ch.gov.uk-specifications/swagger-2.0/spec/orders.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/chd-order-api.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/search.api.gov.uk.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/oracle-query-api.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/3pa-register-api.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/item-group-workflow-api.json"
    SPEC_ARGS="${SPEC_ARGS} -spec-filename=private.api.ch.gov.uk-specifications/swagger-2.0-private/spec/document-signing-api.json"
fi
