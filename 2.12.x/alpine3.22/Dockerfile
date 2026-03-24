FROM alpine:3.22

ENV NATS_SERVER 2.12.6

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
    aarch64) natsArch='arm64'; sha256='fddaf3f223c7af3f4d0a0d2c2fc084406e6b3ec7adfd1b9e6a37fbd03bfe222f' ;; \
    armhf) natsArch='arm6'; sha256='db693c694a647198ee23e43c0c34055a02d53f2b133184025d650c03d72a92b6' ;; \
    armv7) natsArch='arm7'; sha256='cd9998b41d16e6339bb11ef7f8402911e6132e01b8506d21ce7e5494188b6891' ;; \
    x86_64) natsArch='amd64'; sha256='77fe7dd69ff5144126026b78355900be0ab0bb4339dc61a7621dcc9b9e9d07a6' ;; \
    x86) natsArch='386'; sha256='b9f6119c607b0095d3b1a342b88cad7064d2fd9bd1e0708adba9b99a5c246d67' ;; \
    s390x) natsArch='s390x'; sha256='90eb878938011d2f15ef365ed278e35191693ccb92255dcf9730348da786bdc8' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b7c68219ad7005a0faca4cce3658dc72b389aacacd346a58aa33bbe7953beb44' ;; \
    loong64) natsArch='loong64'; sha256='506bf995f1d4b3a9a444734b93eb5de15bd1e5cba5fa91bb2071314cafbee019' ;; \
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
