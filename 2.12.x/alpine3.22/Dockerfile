FROM alpine:3.22

ENV NATS_SERVER 2.12.5-RC.2

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
    aarch64) natsArch='arm64'; sha256='310435bc06b5173bc21746f6fe5184329f395de398a2857573f7e9d4dee9edb6' ;; \
    armhf) natsArch='arm6'; sha256='ea8b0cef8d27f7111ec9843d5db98c01340baadb11087f9d706c7abbe26c37bc' ;; \
    armv7) natsArch='arm7'; sha256='aa6270b4b925af59ebc378dc126cb95d30f26e97100a4d0d4ebd5526ffb3e7c4' ;; \
    x86_64) natsArch='amd64'; sha256='056c5075825d974df41c7daabdb45e464c4597435caefb4b6a571e1759d2c306' ;; \
    x86) natsArch='386'; sha256='c93a600f5dda700387f02213f74bd0d7ba6e42682707ecbeca616d82588848c3' ;; \
    s390x) natsArch='s390x'; sha256='74969d6f798c0ad067e184562888c11e8a29c6cd94ae1e7e269c866c09d00111' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b66d8979d069aff92d26052fe8bc7f0e63c3b097472c846bcec61697e5e96c0c' ;; \
    loong64) natsArch='loong64'; sha256='c0d9ce9c8aa766b217b9500ce5ec6e989007de0e4e8d7fb78dd1249a27e91f66' ;; \
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
