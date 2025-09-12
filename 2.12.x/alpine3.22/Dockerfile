FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='683c69a310a2b528041a90ca2ea51764e9414cf5a582feef5c48defed0fb578e' ;; \
    armhf) natsArch='arm6'; sha256='200f80e20c29127c56fd56a3bef277933fc23c245381c188a8601ef57da2d859' ;; \
    armv7) natsArch='arm7'; sha256='e9da1480182d394d9f909306f31459c37fb496f93fb0f807c9e2fd7d199fdbd5' ;; \
    x86_64) natsArch='amd64'; sha256='ec3933a4a68ba0af12f1e02b2ca5ededd63c29add9d4620acc4b2480858ea3e1' ;; \
    x86) natsArch='386'; sha256='fd771d5897b86e27862d28a27c660005f4b10d9d72f3dec5c3c767046803fcb5' ;; \
    s390x) natsArch='s390x'; sha256='b8862fd3a7061df754e527ea2fdf6851e71580188e379d0f1c7a7a5d1bd6e15e' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b7ba1176fde3f99f58dde2ad5b895b83090cef8288b9009974b981851a90062f' ;; \
    loong64) natsArch='loong64'; sha256='983412d6ec20eca9fdc39b7820e0d2e66b7c0c0a75b19aea3f375e21cad90a5d' ;; \
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
