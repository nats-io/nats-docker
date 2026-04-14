FROM alpine:3.22

ENV NATS_SERVER 2.11.16

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
    aarch64) natsArch='arm64'; sha256='db7822e823829414a66b81f0553d9acffc27d6576d66313d92366c9ea2e85afb' ;; \
    armhf) natsArch='arm6'; sha256='77715f8c48eb3223e03bf814e98c7783f41d9476b61761ebb875d0070ab1f89c' ;; \
    armv7) natsArch='arm7'; sha256='98356346374d7a6b43910aa977e9b322b9c19638d666a5ff512efb5d3a46e7b8' ;; \
    x86_64) natsArch='amd64'; sha256='90b1a5d5c379e68862018b8eb731ef20bda9da86a33b7432f5d58e3dd14a9230' ;; \
    x86) natsArch='386'; sha256='e6ff1d7b6eaa5ab05197ffe5f125b528b2be9a317214c0206f49c9874939f8b5' ;; \
    s390x) natsArch='s390x'; sha256='b003d96583150ac7ce3091bb06e5e31a6e40e83929381bfa4909d27b45b85e31' ;; \
    ppc64le) natsArch='ppc64le'; sha256='8e7f8335b7c4e82930507e4c0326ef2711e073782f034b892a204613e41f974c' ;; \
    loong64) natsArch='loong64'; sha256='16ecea37b754306b07477d5f747f67a5bad18ccf0e47f7f11e51b4872f4935ca' ;; \
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
