FROM alpine:3.22

ENV NATS_SERVER 2.12.3

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
    aarch64) natsArch='arm64'; sha256='75ce2c04356e9581441e88feb9c270f54fbe2aedaa53caaaa7126a5978ba753d' ;; \
    armhf) natsArch='arm6'; sha256='5df725529a1ae8d899fda720b161cb955371d8f37ee7de40f47dfc6d83a70d61' ;; \
    armv7) natsArch='arm7'; sha256='1281c924aa754bfefbb14c155f8651f390e428812319084cc14de36d01c3b3c9' ;; \
    x86_64) natsArch='amd64'; sha256='3f113d8f3d64f28239e12deeca9c9941104def9e2a8461fa076b0065b4e76327' ;; \
    x86) natsArch='386'; sha256='9a13728e0599d22a5d3b10f4b20b4a49a9e1ababe56f89b84eab94ff1caf76dc' ;; \
    s390x) natsArch='s390x'; sha256='be78b6348f91950bcc8f9e2a04c071b90a9cf2296a32789d6163171ba7b540ea' ;; \
    ppc64le) natsArch='ppc64le'; sha256='4140bdb33ec56d007ec263a543c3bcf7659509c2a80a6dcf97d878ed3f203186' ;; \
    loong64) natsArch='loong64'; sha256='4a1e5f84d9bd8c3620085ac9e7d26f101ba1bc29ce180bd353404430087f2001' ;; \
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
