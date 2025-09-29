FROM alpine:3.22

ENV NATS_SERVER 2.11.10-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='fe4eba2053769655e6c2c3dac7dba7f9a79528f3132a7888c9174320b3d0b1ec' ;; \
    armhf) natsArch='arm6'; sha256='1c0f4c94d74c9a4b3e12ab8b3f494ba63559548075630c458ce4f7a530db01c4' ;; \
    armv7) natsArch='arm7'; sha256='89ef24bf2afb82f021c413d7fa1ae842407632882e92eb16b6e14e748af05328' ;; \
    x86_64) natsArch='amd64'; sha256='77c043b00bb611fcec219301a4c2e15c653a894f0269652ec0c1f17fb7fa2847' ;; \
    x86) natsArch='386'; sha256='c11753d2f6fd01f1fcd6e677149490cdec0ca791b9aa77218f891c32925c3356' ;; \
    s390x) natsArch='s390x'; sha256='a512654523320dc79ba564399b1a825b6991327e2e8da90f32d2fea1be45dfea' ;; \
    ppc64le) natsArch='ppc64le'; sha256='1b255f020232474de57fdf9775b620a2312bab1bb8b034b676fe94e082c98313' ;; \
    loong64) natsArch='loong64'; sha256='e8b1379887646c8423ff46107008cacb9be7550ea9992b4b3a2caea13a01ed85' ;; \
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
