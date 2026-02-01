FROM ghcr.io/dockhippie/golang:1.25@sha256:0a69525c852eec98f4537c0424fcbd253084c42a9536702adc1ba4c99ece736c AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:290fa97fc3c00802b2a80f40cc21cdd5e6534a4422dcdb0abd57738ac08e86bf
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
