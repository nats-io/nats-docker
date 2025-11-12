FROM alpine:3.22

ENV NATS_SERVER 2.11.11-RC.4

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='c289342c2faf736fd3481f8deb8706c59988d9340878f71996ca9822882bf047' ;; \
    armhf) natsArch='arm6'; sha256='c81b2696ee3c1929c62a45dc09c78fd4e36b9f123c3568245a6e55a361a1ed4f' ;; \
    armv7) natsArch='arm7'; sha256='2781a8c14f270a74aad6e265979dbeb2e7bac8f6dc4945bdce4679d410579a1a' ;; \
    x86_64) natsArch='amd64'; sha256='49616081d5512fc3da72ccdb0337a35492df70947de44857e363bd32557118f1' ;; \
    x86) natsArch='386'; sha256='206ef4abb7f1a56bf7c07a03ea52df003e19de020c619f30821f6e018d288a7b' ;; \
    s390x) natsArch='s390x'; sha256='d8ed32315af7d0545b571d46da1fa58c6e08c9305381b0a05cb62f5a607cde8b' ;; \
    ppc64le) natsArch='ppc64le'; sha256='759022e75677e06e20ee06d3ec682e228288977e410102f61ab0f4af05334f63' ;; \
    loong64) natsArch='loong64'; sha256='30938d69618896cb6827fa69eff0109cc3e383c59fdf7feac333ffb79378b4e9' ;; \
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
