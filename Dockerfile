FROM ghcr.io/dockhippie/golang:1.25@sha256:56a5bbb8faa06587a222aafff417888fe9313db42eed858fb2b11a78286794bd AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:9d02517b6423d07d763d4eff86f19dc0d329791380e946438822137c9244da30
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
