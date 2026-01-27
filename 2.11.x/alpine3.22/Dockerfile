FROM alpine:3.22

ENV NATS_SERVER 2.11.12

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
    aarch64) natsArch='arm64'; sha256='86364a25aded16d070f4c361412aa178318e267d213d08d86932010756ea387c' ;; \
    armhf) natsArch='arm6'; sha256='6b41b87d8fc849a61aea8773caa46dc00987936e0e4e7960b7c95b8d658fff43' ;; \
    armv7) natsArch='arm7'; sha256='dce4acaefe771379cd4251f9483e6daa45b417013087313bd7c9d4332bc1c72f' ;; \
    x86_64) natsArch='amd64'; sha256='4a1a890d534e383e04dda4a61aa09c8da8989702a007a5260af8c29e1ac808f4' ;; \
    x86) natsArch='386'; sha256='8edea23f6d8bfd48967c80c747cde7fff6437efa1e3207a506a5ac71d70c6fcd' ;; \
    s390x) natsArch='s390x'; sha256='7bafc5f3a8fc95bdcbeb73edafcbdb5c73ddd4277180ff2f41cdc78c3a1715c7' ;; \
    ppc64le) natsArch='ppc64le'; sha256='be0864949657e48d7f8950366f77c7529a38a9fce3b8b9b0c642cc9c4120bf67' ;; \
    loong64) natsArch='loong64'; sha256='fdf489203eaa086a7b515d21a7bbea2d5f85a3d200c8f3cffd817d721c02d102' ;; \
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
