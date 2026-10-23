FROM ghcr.io/dockhippie/golang:1.27@sha256:9fd44dfcdb09d8113e64940398b3356ca2bbe0d7a60c55c5ab8536b7939729de AS build

# renovate: datasource=github-tags depName=philpep/imago
ENV IMAGO_VERSION=1.9

RUN git clone -b ${IMAGO_VERSION} https://github.com/philpep/imago.git /srv/app/src && \
  cd /srv/app/src && \
  go mod tidy && CGO_ENABLED=0 go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:0518a97b1c6406d9777d435432dcb525b4f47a84562e13a6472f55ac6623f9f6
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/imago /usr/bin/
