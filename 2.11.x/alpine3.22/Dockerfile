FROM alpine:3.22

ENV NATS_SERVER 2.11.15

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
    aarch64) natsArch='arm64'; sha256='0745274620731eab1a6463609f8291589e5a408356411e7dc89cf4bd5747684e' ;; \
    armhf) natsArch='arm6'; sha256='cd11a96b5a8707c3a76a3a41ddf7404b7c1a5b4794c7ee4c1c2377ebf7b6bdc1' ;; \
    armv7) natsArch='arm7'; sha256='8dd7965446ab48d0f5faa3bfbf899c44d991a504a5c9d9fe88ffe15ee541d114' ;; \
    x86_64) natsArch='amd64'; sha256='7035d70262d1ce85d0f58df6530be3eab16c7ebe0eaa4d48868460c796e87cb4' ;; \
    x86) natsArch='386'; sha256='9b66a56df40b827d9f186a5f586a56babc85188f736f4748d034e8dee39a6c7b' ;; \
    s390x) natsArch='s390x'; sha256='fa2ad3e10a9f9fe733bc8ced81025cce0a1ca7e96889b30e1c97ab147e1deaef' ;; \
    ppc64le) natsArch='ppc64le'; sha256='c3cbda79292ee463c5422dc4f51a6ce09f837a33c716657893592e301555b97b' ;; \
    loong64) natsArch='loong64'; sha256='19900ea0e0fff742cbb40af5e387cb1b8deb7d1cb1101d07c6b2222bdf132636' ;; \
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
