FROM alpine:3.22

ENV NATS_SERVER 2.12.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='84d33b50a39bab605b0d5e0223fc15979ef97419b2184a5a5b7eb6a6d7561fc6' ;; \
    armhf) natsArch='arm6'; sha256='1098aeba5873d91a485dcb60ef483e1ebcc337fbfb1eeec2ffbf3ba9d4c10242' ;; \
    armv7) natsArch='arm7'; sha256='6f16c8718957c646bb7ea5a6d762492bf78be94018a7057ce36ab9ad550ad32d' ;; \
    x86_64) natsArch='amd64'; sha256='db587fd8b36ac732a8434e748b026ef77ed9cb714a4e57bd010b1de93c2f3801' ;; \
    x86) natsArch='386'; sha256='a117846d4495e809a5e42655488f44d0d4044b5a076f7753df759e7e6099f60f' ;; \
    s390x) natsArch='s390x'; sha256='c3812ec35c52c4b9d0b19e848d82586236bd913c056f8c3673f2990b9de8feaa' ;; \
    ppc64le) natsArch='ppc64le'; sha256='2d2f028c8747c606abfd7d653f492d43deb79a387b9643962b09dfb628c57e17' ;; \
    loong64) natsArch='loong64'; sha256='9b66d798d12afbe643bdee07fb1fbc9f0f7ebfc347cb40a2274a7b4445f914b6' ;; \
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
