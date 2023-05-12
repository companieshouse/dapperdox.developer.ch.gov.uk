ARG IMAGE_VERSION="latest"
FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-core-runtime:${IMAGE_VERSION}

ARG S3_RELEASE_BUCKET=""
ARG APPLICATION_NAME=dapperdox.developer.ch.gov.uk
ARG APPLICATION_VERSION=""
ARG AWS_ACCESS_KEY_ID=""
ARG AWS_SECRET_ACCESS_KEY=""
ARG AWS_REGION="eu-west-2"
ARG FILE_NAME=""
ARG PORT="10000"
ARG INCLUDE_API_FILING_PUBLIC_SPECS="1"
ARG INCLUDE_PENDING_PUBLIC_SPECS="1"
ARG INCLUDE_PRIVATE_SPECS="1"
ARG DAPPERDOX_DEVELOPER_URL=""
ARG CHS_DEVELOPER_MOJO_PORT=""

WORKDIR /opt

COPY docker_start.sh .

RUN dnf install -y zip gzip tar aws-cli \
    && dnf clean all \
    && aws s3 cp s3://${S3_RELEASE_BUCKET}/${APPLICATION_NAME}/${FILE_NAME} . \
    && unzip ${FILE_NAME} \
    && rm -f ${FILE_NAME} 

CMD [./docker_start.sh]