FROM alpine:3.22

ENV NATS_SERVER 2.14.10

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
    aarch64) natsArch='arm64'; sha256='d86b596f7fb232e3ba297b5fb9d342d72af1e51feb37d9f777e54f3e02906451' ;; \
    armhf) natsArch='arm6'; sha256='12a93a4a78b255edf8b3f5644380211f5db549647a3a3f8e0a102971ac35455b' ;; \
    armv7) natsArch='arm7'; sha256='510062f25ee6552d65fd5c3cc8600e62f5c618ba3c2a5364b97a8f6cebea31f6' ;; \
    x86_64) natsArch='amd64'; sha256='464f118a8aecf293e405514c1ab2c197a5d9209e58e36a5d05ad9577e5ee9b99' ;; \
    x86) natsArch='386'; sha256='e106f92c7718a59080b0ccc6159c92d3d29d11793ca76b3b09b9fcaaf15fdd3c' ;; \
    s390x) natsArch='s390x'; sha256='6735b3de92459d1a98dc1000fbbf75597e94d8b7db0cda4b5c5b35cd75b786cd' ;; \
    ppc64le) natsArch='ppc64le'; sha256='a9045e58b8d4ab6456e4ce158ebdae96b018284286f2cec0eb56b2854ee59b81' ;; \
    loong64) natsArch='loong64'; sha256='8e772e37439c2df441a06ae15611dac12fc3cff1c7d1c094bb1fe360f8266b7c' ;; \
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
