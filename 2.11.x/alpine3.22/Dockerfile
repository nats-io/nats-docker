FROM alpine:3.22

ENV NATS_SERVER 2.11.9-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='b0fbeade19bda0b789d9fe3aec33e3072200a9ebd067e45bf579e7b3ef59d3e6' ;; \
    armhf) natsArch='arm6'; sha256='26fb5e6904b7810f62d25e7cbf75ff9723c6f82e68ae43b63dedf4ba7dd58cee' ;; \
    armv7) natsArch='arm7'; sha256='f9464f2709d83d3467228bee2ea533dc6f2f07de4afc38a93dfa317b29013258' ;; \
    x86_64) natsArch='amd64'; sha256='472db5338fdd9da314684caa97a8022bbf2dabb9b9aff95d20d1bad03aaafe55' ;; \
    x86) natsArch='386'; sha256='ca5b3eb92e9c816630a0e41b3a18000331ffaff381bb1752d1c55c8d66ef6ca6' ;; \
    s390x) natsArch='s390x'; sha256='b262aa6aee8f51f2e213b98647e2f6a7085e797c7b1b7801627b19565d63fd14' ;; \
    ppc64le) natsArch='ppc64le'; sha256='1c72c65aa0ac5287869a6300dba4fa2b256bcc8503b8b4b913d0511ce2992ee1' ;; \
    loong64) natsArch='loong64'; sha256='9339db2c2d84bf20318ec80e52e134dbc6308869b20fd9bf314f037ff15d864f' ;; \
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
