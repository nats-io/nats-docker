FROM alpine:3.22

ENV NATS_SERVER 2.14.10-RC.2

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
    aarch64) natsArch='arm64'; sha256='3a955174a9dbab9703bcdd2e4258d2f66e7f7f8a5a68f8c5a1ebf45dde97ee68' ;; \
    armhf) natsArch='arm6'; sha256='23a41c45b4aee563787b7950bd608db3ab694e544a5c00116f3117de0ef9d60b' ;; \
    armv7) natsArch='arm7'; sha256='5edac75b7450f5e391a75f7e615cfe1758bbbf56bea68fb00ade32633be64193' ;; \
    x86_64) natsArch='amd64'; sha256='910be96557cf173bc67c916ea524ba2721f6ed2ccc63a1d445cab6c63f8029ec' ;; \
    x86) natsArch='386'; sha256='b2adbbdd9ec99763514b32338b057ff28e9029e018a55f6f5189ac335b9e608f' ;; \
    s390x) natsArch='s390x'; sha256='d8718672392e0ac37e65d58fd4ea67256a09c2dd377d5b519bb35cb6d5d6f107' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b16d28057017d21f7f519dd2bd6bbcbecee43bdf7478ab2ce444da6bb0deeb77' ;; \
    loong64) natsArch='loong64'; sha256='2d131a2bf5ae3fb6cda606c044c15d327e179e36d0f36621b91bd5f10151a006' ;; \
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
