FROM alpine:3.22

ENV NATS_SERVER 2.11.12-RC.7

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
    aarch64) natsArch='arm64'; sha256='c5fc8bab0989329f2637b8cf50c98801fc712603b850eec7b748ce4ff7bfa4b2' ;; \
    armhf) natsArch='arm6'; sha256='71bc17154f492c6d94f35a1f8d362e269a96269dd708d067d1a25cefbcfc0c5b' ;; \
    armv7) natsArch='arm7'; sha256='f36edfa1e8c3a00e7afdfe17b019f1e63cfed9bed8c38c1eff3a1024bd51f6a1' ;; \
    x86_64) natsArch='amd64'; sha256='14254c19ead70d1794028917ca551cc81289e1d83aedbe3f0facf927055cbf5a' ;; \
    x86) natsArch='386'; sha256='3c8a49750a31a3c05a04b9c90a15ae9724fc437541e56848226193cec81cc56a' ;; \
    s390x) natsArch='s390x'; sha256='de8152ae23eda5784feb380e25e86fa22ca51abcefca8adad0fb704f83126672' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d1d923b6e1a443c401b53964e47170e38cef0286d0dd254911e5ac96a3caa4df' ;; \
    loong64) natsArch='loong64'; sha256='eb6dd2bf006e4ff40de3542b9b6bf9f65cdfdc0f57d40bc5ba50f5a41d58ec3d' ;; \
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
