FROM golang:1.15-alpine as builder

ENV GOPRIVATE="github.com/companieshouse"

RUN apk add --no-cache git openssh-client build-base

RUN git config --global url."git@github.com:".insteadOf https://github.com/

WORKDIR /build

COPY . ./

RUN git submodule init && git submodule update && mkdir -p "${GOPATH}/src/github.com/dapperdox/dapperdox" && cp -r dapperdox/* "${GOPATH}/src/github.com/dapperdox/dapperdox/"

WORKDIR /"${GOPATH}"/src/github.com/dapperdox/dapperdox

RUN CGO_ENABLED=0 go get && go build "${LDFLAGS}"

WORKDIR /build

RUN cp "${GOPATH}/src/github.com/dapperdox/dapperdox/dapperdox" /build/dapperdox/

FROM alpine:3.12

WORKDIR /app

COPY --from=builder /build ./

CMD ["./docker_start.sh"]