FROM alpine:3.22

ENV NATS_SERVER 2.14.6-RC.2

LABEL org.opencontainers.image.title="NATS Server" \
      org.opencontainers.image.description="NATS is an open-source, high-performance, cloud native messaging system." \
      org.opencontainers.image.url="https://nats.io" \
      org.opencontainers.image.documentation="https://docs.nats.io" \
      org.opencontainers.image.source="https://github.com/nats-io/nats-docker" \
      org.opencontainers.image.vendor="NATS.io" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.version="${NATS_SERVER}"

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='4acd22abf8411051b7ace1a5c878009569d8ab8641b7acc41dedad4257b9186c' ;; \
    armhf) natsArch='arm6'; sha256='2e2356ba122d4a25c5ddcf0ba468503715950d139fdc20b0e54a7ac123c0b6d4' ;; \
    armv7) natsArch='arm7'; sha256='564d57f5b8bdf6a9c3b0ccca934380b2f061733a98ecfb8e6442e0ebff2e5063' ;; \
    x86_64) natsArch='amd64'; sha256='7ae805e0a6afe015dd8b98f63e56f791c542b7728bf0d0647d9c10934c042089' ;; \
    x86) natsArch='386'; sha256='459acc63085ac91456ea7b3a54dbb98bc82485a31a940d1a6d596c9d4e142117' ;; \
    s390x) natsArch='s390x'; sha256='783941ec42e0d1e64a4d3b1f62b721d62b0899276c829ceb066a59db5f739a4b' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d7aa203f94eb62d4648ba2db724ffef26bc22cb408cfeb0123c377b67b7396b6' ;; \
    loong64) natsArch='loong64'; sha256='8f6d6a1219c89528a791a9b0cfee6834bfeba37c6eafa63ff388e385177345cc' ;; \
    *) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
    esac; \
    \
    wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
    echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
    \
    apk add --no-cache ca-certificates tzdata; \
    \
    tar -xf nats-server.tar.gz; \
    rm nats-server.tar.gz; \
    mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
    rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}";

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
