FROM alpine:3.22

ENV NATS_SERVER 2.15.1

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
    aarch64) natsArch='arm64'; sha256='e2fbab4cad7d3c76e3052eb959570393c9d73ba756b70bf8e9eea61e9ae6d49c' ;; \
    armhf) natsArch='arm6'; sha256='a8c76cf2e716745ea140636c02f89195fb209ccbd01be46d3d973acee7d8d2e7' ;; \
    armv7) natsArch='arm7'; sha256='ddac3887f9b0e17d657d1124bfd648d2f3d98b8b12a0918a0443eff079d2c238' ;; \
    x86_64) natsArch='amd64'; sha256='bf5edc7b1ce98e885c368cb43a886eb148dc5d0551d99f3cf6141fb5e1954c70' ;; \
    x86) natsArch='386'; sha256='9fde80807787a77e25d0143b0835b8a7de8b735e9ebe01fcbcf0205e00f7f06b' ;; \
    s390x) natsArch='s390x'; sha256='478644ef83c46f585f9714b05201b5596e718cdd55ef295fb31abef6a71b4646' ;; \
    ppc64le) natsArch='ppc64le'; sha256='4918414d24b16c30e71352e362b2d89e9e47c557514cefb5d4c6f2523cfee73d' ;; \
    loong64) natsArch='loong64'; sha256='c0875670e7a5fda318e4114cd549b39c77f3294ebb32f90f78c6e7c83635d8d9' ;; \
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
