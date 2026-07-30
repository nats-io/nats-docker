FROM alpine:3.22

ENV NATS_SERVER 2.14.4

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
    aarch64) natsArch='arm64'; sha256='2143f4317ac8e1dd42793c912fa09b405c7036ba181b2a3002b74501d13562b0' ;; \
    armhf) natsArch='arm6'; sha256='96bf604d44f03d2a572f38fc3df5908827ad14ebe3aa3b2e2b1cbb88bd52c739' ;; \
    armv7) natsArch='arm7'; sha256='52b6039d5652264d1d528650a8feded0a61ad92c5bc2a8cd25e95d6e2606d0e2' ;; \
    x86_64) natsArch='amd64'; sha256='20f9d6a199560f243610908bcccea2e27e9f47213242d1c609ca46d1d73e91ea' ;; \
    x86) natsArch='386'; sha256='ffa936eedc8d50708da79d8e0c43bce7c5fdd268e58b5b5e8cf54a1c1c3043e7' ;; \
    s390x) natsArch='s390x'; sha256='121830ed6492c0baf213993c0904719531c8108272d5d139df0ac459bde1ba4d' ;; \
    ppc64le) natsArch='ppc64le'; sha256='cc577f9ad2adbc3a873282c12f8d507f33dbd6c42e433ad8334c4c9ca8f84448' ;; \
    loong64) natsArch='loong64'; sha256='e42639f78170fec5e0c9928701bcd34718e5e32a1fc15b4837a745dd37fc98a4' ;; \
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
