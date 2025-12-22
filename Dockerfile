FROM ghcr.io/dockhippie/golang:1.25@sha256:ad4fcf592b62c32de1b4edc06974eec309326973babb812d1177dd3a6dc1d254 AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:f857559a03da3017be1663750116349e56d315cf0f86e64f508aa0613a9ef313
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
