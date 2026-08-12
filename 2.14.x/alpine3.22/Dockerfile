FROM alpine:3.22

ENV NATS_SERVER 2.14.5

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
    aarch64) natsArch='arm64'; sha256='673a98d3faa79dde3f9ebf16d6dfac36a5f694e7ad2015e4954dd7939c85cd4c' ;; \
    armhf) natsArch='arm6'; sha256='e0c6a5ce708c7a57cae5008805397046f6502c627cdc00bfff33af0929d07d50' ;; \
    armv7) natsArch='arm7'; sha256='c8796b63a8603fdebabd63146ac3d3997c29a2829fdd2af6db320f4a287f2e71' ;; \
    x86_64) natsArch='amd64'; sha256='5e3b603d47c447bda1f77f9ac16dbf91c90aac4ff3681f8fbbc7201e4ed99355' ;; \
    x86) natsArch='386'; sha256='7eb520d5080d2c4b2e9ad0866aa301f7c7af35058bfae61c1ba0cef472d21d47' ;; \
    s390x) natsArch='s390x'; sha256='829193e8c592e0df5f15402c27417df18d26503d22b77dfc9491982fe0b51a67' ;; \
    ppc64le) natsArch='ppc64le'; sha256='5d8f1a264a3bc4b30899814ae8e898b1268e817074635adddd24b32f388e4cc4' ;; \
    loong64) natsArch='loong64'; sha256='e0c584e45453c5a5ed387f14a96eaa8cb84cb110f0ff9031699087b23e3b2c2d' ;; \
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
