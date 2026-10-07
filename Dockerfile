FROM ghcr.io/dockhippie/golang:1.27@sha256:74a049afe4743969b7c913ea6c71ee1517bd8c4244225d21111cb4ced5064b4d AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:e0483a32bcd11999313e31a424fb40967f605ff34d7f09f02ee1732a14fd9071
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
