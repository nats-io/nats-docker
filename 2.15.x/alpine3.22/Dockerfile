FROM alpine:3.22

ENV NATS_SERVER 2.15.0-RC.1

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
    aarch64) natsArch='arm64'; sha256='cc374cbf4e11972c8bcd5879e83231182bdf55296815913b1864c3b305c46323' ;; \
    armhf) natsArch='arm6'; sha256='06b4e223a244570bb9c8aba31a5a48a22b457e1a198902cb5d65a51339de8425' ;; \
    armv7) natsArch='arm7'; sha256='34e023e26bd193f2cc34549f2ae4b8389535fa345ca21b0cb3ccdc31a92f5fe9' ;; \
    x86_64) natsArch='amd64'; sha256='1d89ee7c1b26380d8534f8bb4353b65ef86114573b6c76090aac2e096c4ba6c4' ;; \
    x86) natsArch='386'; sha256='97df1609511bce905a8fb834a6ce9c45454adef81b3cdd817651cd2f2a2c8735' ;; \
    s390x) natsArch='s390x'; sha256='756571de3381d46ec1cbecd39e05ab6bd8237a96eae3bac68ab78c272cbb799a' ;; \
    ppc64le) natsArch='ppc64le'; sha256='3e2897b7bef97b96564bb618bfb0b4af0b00b289619409dda2e4fb090bc51018' ;; \
    loong64) natsArch='loong64'; sha256='82e0215c70fe9b34dc9e9ec31243118e44e5a052f0300dc3a9127fda3e58b0f1' ;; \
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
