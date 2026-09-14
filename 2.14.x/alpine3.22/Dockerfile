FROM alpine:3.22

ENV NATS_SERVER 2.14.7-RC.2

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
    aarch64) natsArch='arm64'; sha256='27b18b676b0486b122a4ff5e14e490951741d04b69d83bbe13b30daccaaefd0b' ;; \
    armhf) natsArch='arm6'; sha256='72c07b1ba8229019315ed3bd7c70251926274590af2e1143cec6e442909ec2fe' ;; \
    armv7) natsArch='arm7'; sha256='e857442e5c9ee6dca545f72966d814ae1c52c0dc0f4c159ff4cbf075d6af78aa' ;; \
    x86_64) natsArch='amd64'; sha256='b4a7df8cfec195fee414963e973e6ba0ec1c8631facd0b2912b76d407af0e054' ;; \
    x86) natsArch='386'; sha256='2f282764d79db1616267e79c690c3367a4051df2c826cc60297f3cc88c1d32bd' ;; \
    s390x) natsArch='s390x'; sha256='341393a6658242347e3d98ef7b1062ea44e1900e1f308f63f6de63d4432fd1b4' ;; \
    ppc64le) natsArch='ppc64le'; sha256='9ed7218f02728088f5f87b3142a0fa0a7fbc13f1440591983f6e5d051a8b9510' ;; \
    loong64) natsArch='loong64'; sha256='111db50cd3d213532272b7c807128e743e9944dabf8093e2f63ac07a2dd202f5' ;; \
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
