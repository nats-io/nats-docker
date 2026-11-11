FROM alpine:3.22

ENV NATS_SERVER 2.15.3

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
    aarch64) natsArch='arm64'; sha256='4a2088b3ec7103bf79d6484f55e80ab5d10204811d9ae6f7a33e8544d98dd45d' ;; \
    armhf) natsArch='arm6'; sha256='8e8b26d30b877ccc27ca02233503a7df610f911cae4864ca81f6dc2dbc318dd8' ;; \
    armv7) natsArch='arm7'; sha256='a7619752fc73450e40ea4946c64f7a4d6cb8939dc5b3b55dd9c11c508b4c2851' ;; \
    x86_64) natsArch='amd64'; sha256='32e18c1e78d7ef4f86e483070eef3abb2647c3d4d67e29668077c7ad81da0797' ;; \
    x86) natsArch='386'; sha256='36612a9bb1025ffb5b2514a9e797f8bfe0948de9f6a9613805ae132992eeb52a' ;; \
    s390x) natsArch='s390x'; sha256='2e4e626413ed55df226e03e60d36db706224cc871dfe45ad5d495a27570ea542' ;; \
    ppc64le) natsArch='ppc64le'; sha256='42177527c9c647ae79350422e62f9006942c0b09c3146940d0518e3e77b80e61' ;; \
    loong64) natsArch='loong64'; sha256='dd4a33aa515a32f88488de1a78d9a4504dab86f91beac630ed1acddb58c6c554' ;; \
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
