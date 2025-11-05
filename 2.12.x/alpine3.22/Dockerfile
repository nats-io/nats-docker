FROM alpine:3.22

ENV NATS_SERVER 2.12.2-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='eccaf4d4ee7ce4c28aa0a769ea541379888010e30495bea15f2da13be3403eb8' ;; \
    armhf) natsArch='arm6'; sha256='c0f1277d1ce226e94a8ca8e9e83dee86099ddecb7244c84b570579c642b55eb0' ;; \
    armv7) natsArch='arm7'; sha256='24e32a4bb11d88ac0cd2a48ed729af76b1281c424d8896bbeb394707d068c4f8' ;; \
    x86_64) natsArch='amd64'; sha256='4012646eeb990eef852499a4fcf132cd3acc8582542775d59a43f286744c25bd' ;; \
    x86) natsArch='386'; sha256='b5897b11c41089b625d6765085a35e6e34b43f78adcd39e755a2ded20735f9b8' ;; \
    s390x) natsArch='s390x'; sha256='22decb5cc1dd7f6e1cc1fb4ecfd8f5960104baf32c29aba9afd52ec11559c16a' ;; \
    ppc64le) natsArch='ppc64le'; sha256='9a00a03bbe25b3a2bd11bf4aa0de6dbf301f4cdab68d547b43fe7b178717c93d' ;; \
    loong64) natsArch='loong64'; sha256='a15746e6cbb61946e7e057458b6d088401e030ef24581ddf1d4b7d1af195d710' ;; \
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
