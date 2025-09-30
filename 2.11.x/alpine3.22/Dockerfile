FROM alpine:3.22

ENV NATS_SERVER 2.11.10

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='f33ff2fad4a106962a7f61e4aa97abf5d2afcedaabd9f5704d1340139ef7957d' ;; \
    armhf) natsArch='arm6'; sha256='df1c0d7e1ebe03a50ea4e984b247c0e027e50a4de970ecd2c635f6146cb3a92c' ;; \
    armv7) natsArch='arm7'; sha256='ac73a918c5ac60d7cc83a46f4ed54d871537c008df7b5390bbdf0ffbc62d5246' ;; \
    x86_64) natsArch='amd64'; sha256='e99ddaf76e0de2cce90e22d6cbe78d52f003e5e97d45b934d287af2f867c864e' ;; \
    x86) natsArch='386'; sha256='250dd991364f73803ab8730990953da15a8f9ddd6353d9f03c290dc484052972' ;; \
    s390x) natsArch='s390x'; sha256='ec3a6a24d5b39bf893621a8164fece50dea2cabc2b8b8a0e265a16536c6139f5' ;; \
    ppc64le) natsArch='ppc64le'; sha256='3bcef404876ab34caeb4da937bb17484dc794ad84c615e88f9dc2c8818b61ad4' ;; \
    loong64) natsArch='loong64'; sha256='d5b9d52b7ac9d20a36d80b0796a694a3bf51b5bd0d636c7291f8c07b964a2a92' ;; \
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
