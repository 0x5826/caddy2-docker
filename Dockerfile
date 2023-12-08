FROM --platform=${TARGETPLATFORM} caddy:2.7.6-builder-alpine AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with clevergo.tech/caddy-dnspodcn \
    --with github.com/porech/caddy-maxmind-geolocation \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

FROM --platform=${TARGETPLATFORM} caddy:2.7.6-alpine

LABEL maintainer="dante"

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache tzdata ca-certificates

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

ENV TZ Asia/Shanghai

RUN apk update --no-cache && apk add --no-cache tzdata ca-certificates && apk upgrade --no-cache
