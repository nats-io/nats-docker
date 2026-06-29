FROM alpine:3.22

ENV NATS_SERVER 2.12.12

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
    aarch64) natsArch='arm64'; sha256='d28651f6690a47f6115562f43570896aa3754aff7421dba0a9c11e99263a382e' ;; \
    armhf) natsArch='arm6'; sha256='3af51b2f7cd5aa7fe86f805ebcda6a136cdfd0ee2d9e39a1951663e51b309f70' ;; \
    armv7) natsArch='arm7'; sha256='ade3527a9c81befae6b6e6d849ca23d9e8fa7e95b597a41f96ad0b74dc751ea1' ;; \
    x86_64) natsArch='amd64'; sha256='0ade8c59f966a37b9898e5f9ae408ad47f64e529423d3d07330848f4c3bb9300' ;; \
    x86) natsArch='386'; sha256='3e68f7fbd79a6febea21ff54baba19d4c51444ee89ffba779b6d86adf4ae6f79' ;; \
    s390x) natsArch='s390x'; sha256='63104abaff9fce8ec9a4ff689da14e1c850b8e039cf4254b5be35da588d01ad9' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b290015331fa69d477acdd6dda18bacecc0a63ec90b51511f664902c4cc72f31' ;; \
    loong64) natsArch='loong64'; sha256='35fd6f8b0904ecdbce217f7e23a21c5f1eb1b8e4123ddeac803c570295213acd' ;; \
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
