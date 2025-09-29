FROM alpine:3.22

ENV NATS_SERVER 2.12.1-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='517848a7f1e5a908c9f0e3f111ed1c6244d4f78ea40980b171fa57e0794848fc' ;; \
    armhf) natsArch='arm6'; sha256='80afbbb0d2518a1330cb7b3d5e0656a7eb2ab78b5f860ea8c0d7d76628aa171e' ;; \
    armv7) natsArch='arm7'; sha256='8946a66ecac2865820b927ecc48309d45b38a212a565143b216ccbf0a9829955' ;; \
    x86_64) natsArch='amd64'; sha256='90fefc84b9bc641f1b90474f86b026ef90061ca4b591b291dcd4f099ee26a168' ;; \
    x86) natsArch='386'; sha256='b71c165478988d1692ba782ba2ed9099dfc94ecb587722ea2e6f413b224ba8ec' ;; \
    s390x) natsArch='s390x'; sha256='c6f26f034660ce699b3204584a10bb3a222c8b7a8e28f983c8e9a7edb2bc31a1' ;; \
    ppc64le) natsArch='ppc64le'; sha256='c3f4706d861eedc88fb71a6998b470ffb551d1393bc0e3c39f2a1d08af45a94a' ;; \
    loong64) natsArch='loong64'; sha256='5c4d074cd938998b07cfe39d387474eab9fafd98c14b34de6eec48a9abc726df' ;; \
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
