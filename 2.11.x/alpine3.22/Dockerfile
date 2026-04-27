FROM alpine:3.22

ENV NATS_SERVER 2.11.17

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
    aarch64) natsArch='arm64'; sha256='d21df24f262f34f8bf6d1f0bca557c08429e433fd9f60f6983105539ae517feb' ;; \
    armhf) natsArch='arm6'; sha256='13e090f2f433d31f1408543ef52204108eb1fcee4ac74b839a3f2f0b72aceade' ;; \
    armv7) natsArch='arm7'; sha256='5c1f445095ea9a455d6dd092967d20dd38c6bc8c4da13d108e7d3a1386ca3c7d' ;; \
    x86_64) natsArch='amd64'; sha256='ad608dd0ea8bbfa58c40e3b8f58ed67478eec26166ec49c502db8d17589b51b5' ;; \
    x86) natsArch='386'; sha256='6bfe7637dd61b9386074294c37c0790061feb39fd5198c34f9d1882c94926d5d' ;; \
    s390x) natsArch='s390x'; sha256='4e19f27f2ee5f2fe9a5480d6b4541b63f58934524c14b839b2d4d32459ca91bc' ;; \
    ppc64le) natsArch='ppc64le'; sha256='822e7a6ab51dca0cda69a3dc274ecf058f4502265984d09d9b45ab13b749a4f3' ;; \
    loong64) natsArch='loong64'; sha256='c410deb61bcad2e39739e4cc4d2a7d8cd84bb17d655d4a1e97a92c98cd309e6f' ;; \
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
