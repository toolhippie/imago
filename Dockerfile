FROM ghcr.io/dockhippie/golang:1.27@sha256:f22ede2fa1f47619bb5f904ce6b1bc04eb7813866a883c527c4ae9064d598368 AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:f07d501357a45f80b1c874224206284cde04a4fa8e7b8784dff9f7d6fa5360f1
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
