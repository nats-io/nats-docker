FROM alpine:3.22

ENV NATS_SERVER 2.12.5-RC.1

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
    aarch64) natsArch='arm64'; sha256='2db1744612c8423c0941cf2e5ba102361b716b2377d3f4f2d4aa68b27f90343d' ;; \
    armhf) natsArch='arm6'; sha256='13d05ac8809888f3fcec48bd2987fbda42c0d267a6f97516609a9ddf3d95e4b7' ;; \
    armv7) natsArch='arm7'; sha256='b2cac4906fe56257cd68170e01537b92d18e86dd87bd9f90035527bda2f9afca' ;; \
    x86_64) natsArch='amd64'; sha256='87873fd10720c4c3884e4c068ae9a7d001ed547a94857b165ba0c25a6efd3f42' ;; \
    x86) natsArch='386'; sha256='b6f91250297dce0a97239619f379cf3cc10706ddb9e0d12eb5124be2a68830c4' ;; \
    s390x) natsArch='s390x'; sha256='9c6e29efba1e322fff15e406226d357eb4e46245ef7d8dc8766805d2fa19f2ca' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b05d43c5026235e5fac27d007b54e28676746fdb0ce0a973d21ab90d7a672281' ;; \
    loong64) natsArch='loong64'; sha256='49bd3585caa53e054b0be18c87d225a6f12b2754f1bed9399050c7a24fb55f3a' ;; \
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
