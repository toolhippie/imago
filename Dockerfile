FROM ghcr.io/dockhippie/golang:1.25@sha256:26330f9326ba939d2b4bf5af25e2bc8d239d9ff59d65f807ebfbd3443e8acdd8 AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:629cd5472f21a622e37a9afabdbd39f489dd22a7fe1e4ced6a0db63589e85dfa
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
