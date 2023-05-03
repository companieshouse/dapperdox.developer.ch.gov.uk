ARG IMAGE_VERSION="latest"
FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-core-runtime:${IMAGE_VERSION}

ARG S3_RELEASE_BUCKET=""
ARG APPLICATION_NAME=dapperdox.developer.ch.gov.uk
ARG APPLICATION_VERSION=""
ARG AWS_ACCESS_KEY_ID=""
ARG AWS_SECRET_ACCESS_KEY=""
ARG AWS_REGION="eu-west-2"

WORKDIR /opt

RUN dnf install -y zip gzip tar aws-cli \
    && dnf clean all \
    && aws s3 cp s3://${S3_RELEASE_BUCKET}/dapperdox.developer.ch.gov.uk/dapperdox.developer.ch.gov.uk-${APPLICATION_VERSION}.zip . \
    && unzip dapperdox.developer.ch.gov.uk-${APPLICATION_VERSION}.zip \
    && rm -f dapperdox.developer.ch.gov.uk-${APPLICATION_VERSION}.zip

CMD ["./start.sh"]