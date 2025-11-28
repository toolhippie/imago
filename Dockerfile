FROM ghcr.io/dockhippie/golang:1.23@sha256:384a2beb92828b3f2aa019b28673ef4a6f61df4451905f39a7574c993d414e18 AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.22@sha256:5b36d6c9994b3dbde7ff8e6140558b673d4ceb4d794c586073b934585c064a37
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
