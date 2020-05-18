FROM debian:buster-slim as fetcher

ARG HUGO_VERSION

RUN apt update && apt install -y curl \
    && curl -sLo /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION#extended_}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && curl -sLo- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION#extended_}/hugo_${HUGO_VERSION#extended_}_checksums.txt | awk -v filename=hugo_${HUGO_VERSION}_Linux-64bit.tar.gz '$2 == filename {print}' > /tmp/hugo_${HUGO_VERSION}_checksums.txt \
    && cd /tmp && sha256sum --quiet -c /tmp/hugo_${HUGO_VERSION}_checksums.txt \
    && tar -xzf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && chmod a=x /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

FROM debian:buster-slim

MAINTAINER Guido Pili <me@gpili.dev>

ARG HUGO_VERSION

COPY --from=fetcher /tmp/hugo /usr/local/bin/hugo

WORKDIR /data/hugo

ENTRYPOINT ["/usr/local/bin/hugo"]
