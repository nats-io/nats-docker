FROM alpine:3.22

ENV NATS_SERVER 2.14.0

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
    aarch64) natsArch='arm64'; sha256='ce7dc5f7d97b70dabc38b13157fed28d7d06227860676143c15c62c5c297996c' ;; \
    armhf) natsArch='arm6'; sha256='b87842c1eb7268286dd873513e0ffc21c7b54d14636c5a5ecb3637deeb523337' ;; \
    armv7) natsArch='arm7'; sha256='3b66be75d9e5ef2ec5c3c66012ff3d03401996c8aa463291ccdd38307b9cac52' ;; \
    x86_64) natsArch='amd64'; sha256='3d8b74dfad39af184c765a6dd120441ed1c648d6672eddf6b304f222661251b8' ;; \
    x86) natsArch='386'; sha256='83528c239f917783fb25e5997bab18ce75e4a8959711ab8fce31fca2174e1d6d' ;; \
    s390x) natsArch='s390x'; sha256='4801bf5e945c50b654f1151129a1e28671bf892cd8a6401ff4b53dd4788e21d7' ;; \
    ppc64le) natsArch='ppc64le'; sha256='8534c79f8eb341ce9dd45fb63ddec40dbbcfd0ba28747e1f9eae35fb93b2381e' ;; \
    loong64) natsArch='loong64'; sha256='89c64b70915dd2f73317cb413f7f3ad373d4602f2b7b16e2417ebf7d5eee5876' ;; \
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
