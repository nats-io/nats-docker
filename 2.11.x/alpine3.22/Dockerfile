FROM alpine:3.22

ENV NATS_SERVER 2.11.11-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='3efc87aa627c6a2b12faa0fba8c1feeae15b6945c25d36ffb25f11925b93222a' ;; \
    armhf) natsArch='arm6'; sha256='f8530695a5d1c966281d308faa77e3b9816006649a3db0e8c135e230af820c20' ;; \
    armv7) natsArch='arm7'; sha256='3be23be47f474170590a1dc6bfb588fc10a8739a64cd0c57fc3911a810704f2f' ;; \
    x86_64) natsArch='amd64'; sha256='f5b8596379ee43e64b93e30dd53eb415f3e563dfd4bab7c4cac1fbca3ea762ca' ;; \
    x86) natsArch='386'; sha256='c79a933bda905bfbc4097ec4b57969ee14514a576e1ddeb7ad16e6fd4368743d' ;; \
    s390x) natsArch='s390x'; sha256='aed73fd8a60b69316b2e0dabe38ec4ae62219b9fb1d08e1f6f46f15bb92a02b2' ;; \
    ppc64le) natsArch='ppc64le'; sha256='4f29c9a177f194548fff7e8f148af0e4069b662765cc4db5b740615ff8dd01f1' ;; \
    loong64) natsArch='loong64'; sha256='ef48b2abe80004ae04366ad43e838d1f157ea7b032a009171ae717d1d521bb11' ;; \
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
