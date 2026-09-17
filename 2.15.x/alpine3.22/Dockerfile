FROM alpine:3.22

ENV NATS_SERVER 2.15.0

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
    aarch64) natsArch='arm64'; sha256='cdc208f5a3f42963a52b6ab06ef65626bb870315dc936e26ba571780c6351112' ;; \
    armhf) natsArch='arm6'; sha256='e29421c251dda2003d16b8d503124a0d690d05f4e018923be7e5e64b446e42c2' ;; \
    armv7) natsArch='arm7'; sha256='ec5f4689d017e07cfa18442e10da051c0f3f9dd2e7f4dc7cdb55a11f1303c952' ;; \
    x86_64) natsArch='amd64'; sha256='5d2c51caca950333aba84911df7d377f826f3a59ec36061c6539105084f65c92' ;; \
    x86) natsArch='386'; sha256='f572eccdbb35ab5c7fef7703a5b6ca49e55d039e441920ba5478972ecdcf7a47' ;; \
    s390x) natsArch='s390x'; sha256='ac50bf4adc8fa6db575ed9293417b6fbec746e71cc9d360aea5cd447e4207bfc' ;; \
    ppc64le) natsArch='ppc64le'; sha256='a402bf73f91f674735cc85aa0e7d06d5dfa3044b98cda6ea9937cfee4e05a266' ;; \
    loong64) natsArch='loong64'; sha256='fdce4b595b4b3a9f83d07ee310334b68a0723c799e969c9ab77f3105158fd64e' ;; \
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
