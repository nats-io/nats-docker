FROM alpine:3.22

ENV NATS_SERVER 2.11.11

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='8d8507c6bac06edf19f1ff3b556074826d94f09223dc4f38184c408491d8be6f' ;; \
    armhf) natsArch='arm6'; sha256='b08c2bfe4be0c5056fe72f7b11158ac9c9c4bee40d16957bcf2b3a12c732317a' ;; \
    armv7) natsArch='arm7'; sha256='c8ba78e993694603262bc0d755d3947e7eb4ca6680e70092260925f2dca61a4d' ;; \
    x86_64) natsArch='amd64'; sha256='566ebc02bd718adf4f28b193f2735c3217eaaddff4ccb830de654b230fba86e5' ;; \
    x86) natsArch='386'; sha256='e7cbfc877aebca367b613a76336dd1046741b6d77f4bd5259c8e31e29cb59f0f' ;; \
    s390x) natsArch='s390x'; sha256='243baad382d7347d485038b97f9357c5796f533ed94408fac0fe5bcbda30d2b6' ;; \
    ppc64le) natsArch='ppc64le'; sha256='949a4ebb2685aff22ce72b887ac3fb53861f5eb9acca3c782bad85aecc8dfe62' ;; \
    loong64) natsArch='loong64'; sha256='5acc16777d0690bb9e31ebc3f2c41793964a4290b66265132fb712f8ad2dd310' ;; \
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
