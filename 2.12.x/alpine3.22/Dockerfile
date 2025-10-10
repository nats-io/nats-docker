FROM alpine:3.22

ENV NATS_SERVER 2.12.1-RC.4

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='6be066ed2f198d0a9af6c52f48a5a1aacce6c6ef01a10f07067c4412b99c6068' ;; \
    armhf) natsArch='arm6'; sha256='f1ce33b7d5c087beb0993b416e37768c6b88ab556c096b97731406e597a7d7cf' ;; \
    armv7) natsArch='arm7'; sha256='419b24f9061a91ac04cc70ff8c3a624f1d2e5244d22b99bbb3e71bdb87379c83' ;; \
    x86_64) natsArch='amd64'; sha256='a6694bed454d95b20097519f5697dd940c2d8db02980617884ca0b45bfe22331' ;; \
    x86) natsArch='386'; sha256='8e9bd8af94314516af9b9d4ffc9d7ffac27dfdf1726071a58c16c529867a22e3' ;; \
    s390x) natsArch='s390x'; sha256='f7de7511e5e343648a9f0d08f5ebeef611b72dc658cd1c589795400d69b9efb2' ;; \
    ppc64le) natsArch='ppc64le'; sha256='fb2973aea1b34f1107f2ce0e7a0c419aac742ba6e4ded834538dec40e1f74945' ;; \
    loong64) natsArch='loong64'; sha256='b8762a360595fbc7ba074388c5c7ede1a85ba4cc64957dda2b470ae4d1fd8af7' ;; \
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
