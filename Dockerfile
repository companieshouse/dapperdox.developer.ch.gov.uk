FROM golang:1.15-alpine as builder

ENV GOPRIVATE="github.com/companieshouse"

RUN apk add --no-cache git openssh-client build-base

RUN git config --global url."git@github.com:".insteadOf https://github.com/

WORKDIR /build

ARG SSH_PRIVATE_KEY
ARG SSH_PRIVATE_KEY_PASSPHRASE

RUN mkdir -m 0600 ~/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    && echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa \
    && chmod 600 ~/.ssh/id_rsa \
    && ssh-keygen -p -f ~/.ssh/id_rsa -P "${SSH_PRIVATE_KEY_PASSPHRASE}" -N ""

COPY . ./

RUN git submodule init && git submodule update && make dapperdox/dapperdox

FROM alpine:3.12

WORKDIR /app

COPY --from=builder /build ./

CMD ["./docker_start.sh"]