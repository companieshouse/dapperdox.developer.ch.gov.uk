ARG IMAGE_VERSION="latest"
FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-core-runtime:${IMAGE_VERSION}

ARG APPLICATION_NAME=dapperdox.developer.ch.gov.uk
ARG PORT="10000"

WORKDIR /opt
COPY /app .
COPY docker_start.sh .

CMD ["./docker_start.sh"]