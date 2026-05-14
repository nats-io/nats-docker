FROM alpine:3.22

ENV NATS_SERVER 2.14.1-RC.1

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
    aarch64) natsArch='arm64'; sha256='c48b0bbb46427075fa6d47f4b639f99f9f6b1b4adcf2ed28181379523b9b8f98' ;; \
    armhf) natsArch='arm6'; sha256='fa51ba7dc43fec0d5d24930d1f6b56c93ca88a26d1b9830424af934eef43d07e' ;; \
    armv7) natsArch='arm7'; sha256='c57b0099a6b0b89f8200e37e034756662179d08ff890f99f002e9674779c6e5f' ;; \
    x86_64) natsArch='amd64'; sha256='fdd800cf565dc5c32f122e1d1bbc34810be72675a27bbc7baf68b7067ce2a9e6' ;; \
    x86) natsArch='386'; sha256='9e66899796640f5fdea2f92e8a73c80527823b00375672dc172516a7a2662bea' ;; \
    s390x) natsArch='s390x'; sha256='7e7d734ff489950d5409250007fad504345ef57d5e765202decfb05f56433c73' ;; \
    ppc64le) natsArch='ppc64le'; sha256='9e9d77cbcdc9a1e8c43dc6839f68b898cdf5d3dc0f5d7e33a02c2373773653a4' ;; \
    loong64) natsArch='loong64'; sha256='eddf206b81ff78bd97f3e69e2eae9122b02ad864dee371f6f4db84da4a6f52b4' ;; \
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
