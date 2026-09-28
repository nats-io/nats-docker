FROM alpine:3.22

ENV NATS_SERVER 2.14.8-RC.1

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
    aarch64) natsArch='arm64'; sha256='ca73eb571f2ac4622f66345cf8995b555f963c03d77943cdd6ee0baf4d767e88' ;; \
    armhf) natsArch='arm6'; sha256='3f3811c9a2d3e4871a666c7f54366543d16c6ae8df04fad7a727cf51e0a60924' ;; \
    armv7) natsArch='arm7'; sha256='b978a792543972c173cc8f41acbe6ecf61906bdf1d951de5d84e2e49c345f2d8' ;; \
    x86_64) natsArch='amd64'; sha256='5dda2f9ed56a320cf68f36ce78a255171194245e4669d5217f91589265c1db5f' ;; \
    x86) natsArch='386'; sha256='4c220932c5d914ded0c79288d89de84081a08111043dbb1c6073316b46cbf616' ;; \
    s390x) natsArch='s390x'; sha256='6afd01e474e0533d49684c5dc846bb948fcc6f8b2df60e8ffa54641621130e4c' ;; \
    ppc64le) natsArch='ppc64le'; sha256='ce8de1e99bce1468472a700407a5ad5bab366d102c8dd09ce11182f41dbbab4f' ;; \
    loong64) natsArch='loong64'; sha256='27139b7d8978e2dfc29ca55e33392e7bba8516710adbdac8d1dfc430b0a3c8a7' ;; \
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
