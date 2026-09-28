FROM alpine:3.22

ENV NATS_SERVER 2.15.1-RC.1

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
    aarch64) natsArch='arm64'; sha256='10fff08c55923d073175be55bdecf5b82dbd526cafec55dc83bd962f5ea748f6' ;; \
    armhf) natsArch='arm6'; sha256='035cd4bc00cd484c635d775db3bc283a764152da28cfe938a09d5176204d4d45' ;; \
    armv7) natsArch='arm7'; sha256='12cb9199b811d9886ad2b604506bb316487d80bc2cf45cbb421adc6f282dd2d7' ;; \
    x86_64) natsArch='amd64'; sha256='ac94adaf3c1965589c5ad5ba9bea8606cd0319754970005349d70950b6a588f2' ;; \
    x86) natsArch='386'; sha256='3a3910899ee7fd1428a12849990e0195b4031917f50a024d608c7ff79df2639c' ;; \
    s390x) natsArch='s390x'; sha256='c119cdc7dca0d53a5fbeeba9b25ac5ee6277169119514e9e7447f91be5b09a09' ;; \
    ppc64le) natsArch='ppc64le'; sha256='0536a7adc0f8c589659ba58d46948a87be15f8aeaf52024d06f8f0d3c5f0cb1c' ;; \
    loong64) natsArch='loong64'; sha256='64b06205b13474e9c73684142b7af8aea7d23f49091dcfd37daad6aaf32c816e' ;; \
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
