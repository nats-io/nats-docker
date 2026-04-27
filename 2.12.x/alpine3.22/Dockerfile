FROM alpine:3.22

ENV NATS_SERVER 2.12.8

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
    aarch64) natsArch='arm64'; sha256='7d20e93c23924cdd5cb6ec51c92f9478c97f9c8a0dbe049dd7ab88af115d622c' ;; \
    armhf) natsArch='arm6'; sha256='10bbd0cc9648c305bc524f63372f6689004d507273b923782299249116d69306' ;; \
    armv7) natsArch='arm7'; sha256='7080cc18aafe35f2d3a073bd25cc19510248ec95c56f4ba88342c91b3aecdcb3' ;; \
    x86_64) natsArch='amd64'; sha256='6abc397684567e133649688a13564ad6de786d64e88253fbb4f6a3aa8c2fca63' ;; \
    x86) natsArch='386'; sha256='bb0973788e963aa0fe070d29a7bbf3255be04079d3842c3d14572b363d854c16' ;; \
    s390x) natsArch='s390x'; sha256='7c654954abd640c61cb1805274a7c69502570b71f0b515565cdf52f9303e39fc' ;; \
    ppc64le) natsArch='ppc64le'; sha256='20d693ceffaf09e79180ad4e1d9411a90fe9791d5aaf1c0f94d6c8b8706824b9' ;; \
    loong64) natsArch='loong64'; sha256='3e418d560a3c872fb6c7fbc3132172615f0482a152d85f5e705c1c9244f6328b' ;; \
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
