FROM alpine:3.22

ENV NATS_SERVER 2.14.8

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
    aarch64) natsArch='arm64'; sha256='0371fa0da81a3f5ea0d64914bb10dbf96c92fea071ff249ee5c1255997fe8be0' ;; \
    armhf) natsArch='arm6'; sha256='667cf79160b99ba0ef44599a06dcac1e8e15558ee83f214219cbf34e37c07d67' ;; \
    armv7) natsArch='arm7'; sha256='9072c840173ef83f03dd14b58c58ae17826ec96c2353fe52a4cdc43647d150d6' ;; \
    x86_64) natsArch='amd64'; sha256='c60504071c86bced5fc1d89410cee2b319a07e01ee64cb14f5934a2238022021' ;; \
    x86) natsArch='386'; sha256='cbf86ab32f33d5ef965d463243f7c1235e4fa7e84bd0cc5eefbb27d2d73f7ddf' ;; \
    s390x) natsArch='s390x'; sha256='d9d27b1ec41e76cf93933fca3892e89a4421ff7679371b2790464bbe5b382384' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b59fc21640e81f7a1a66b1ee7b2e939a74b277729d581cf97bb8e7bfd1cd411e' ;; \
    loong64) natsArch='loong64'; sha256='51a2eda8d532cd245c07f0e4a7aeffeb6563e74ca946fd08ee5c63ec8099cc02' ;; \
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
