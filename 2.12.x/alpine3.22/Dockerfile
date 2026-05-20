FROM alpine:3.22

ENV NATS_SERVER 2.12.9

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
    aarch64) natsArch='arm64'; sha256='72b5841a019f6c5a0be78d3cf21cd293446317e6b4e769e3b9d72090f2d87afc' ;; \
    armhf) natsArch='arm6'; sha256='eb159297eb8539e47f615180b1de759e6a735cfe3274a31d405301e1c2ee2aec' ;; \
    armv7) natsArch='arm7'; sha256='2573d1cb723f55d81c58e854e63c771e1a2d954a91ed0a23042e7e38fa0d405c' ;; \
    x86_64) natsArch='amd64'; sha256='b126515225aa2265a0088e0170f2a9de4c7880b2388cc7584aa77859ce831e3f' ;; \
    x86) natsArch='386'; sha256='c29a867045b25e300e501101abc3714e4e56c89b35b90ddbfc55ec6e7928eb17' ;; \
    s390x) natsArch='s390x'; sha256='d508d9f40853828623b50e367a4dd0394361352195b3669d5da7966991e30c03' ;; \
    ppc64le) natsArch='ppc64le'; sha256='a2dcbabba4aede66b9939d59e829d61417fffa7c08c49635b9a550a23f733cdc' ;; \
    loong64) natsArch='loong64'; sha256='5a0347fa1400a569cc798da80001fca8c68dc7193daea334df9ea6ec5fe2649c' ;; \
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
