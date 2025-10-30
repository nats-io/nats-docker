FROM alpine:3.22

ENV NATS_SERVER 2.12.2-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='549443a50208ad825a03bd7acaa2f3d0b7f0c120deb5e7a07e0e3b40a1e6d6b2' ;; \
    armhf) natsArch='arm6'; sha256='c16fca210bedcad49158b8becf468924819f010312ce312f563211905437ce35' ;; \
    armv7) natsArch='arm7'; sha256='79429f2a395570581d8157e6bd00ce9d1c25f7c0d2a0d6308ee72f624a4db5f6' ;; \
    x86_64) natsArch='amd64'; sha256='d158a833f53fd6e615f3f4280fbfd54c6c52a8dc2847234eed70298a9b5b2820' ;; \
    x86) natsArch='386'; sha256='f3b96ebba49ee758cfe1c72533b54efa3a0bd75f43d6b2d9699d1fd7a62c6588' ;; \
    s390x) natsArch='s390x'; sha256='0772732a8b287142f2543d5e0171bbc6eb687218e161e37cd30bc13f517826eb' ;; \
    ppc64le) natsArch='ppc64le'; sha256='0224414fb6db2ba6d418c42bc18678b4109e14ca81e3b26486537dc8b35abe67' ;; \
    loong64) natsArch='loong64'; sha256='ede8fcdc4ec9c9268ec0b33146ece0cfaa0335427596b0965aef950fc7800aaa' ;; \
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
