FROM alpine:3.22

ENV NATS_SERVER 2.11.7-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='104e4f9a0f86469decb584f74e82ddb446ca05dab1753e3a38ddcb7ed5fc9a8d' ;; \
    armhf) natsArch='arm6'; sha256='3b1a216254cc0a9d3a88c9327bf5d5bd80763c49f572633619edaa31f50019bb' ;; \
    armv7) natsArch='arm7'; sha256='4be4c4a749f5d92a68e8b198ab94d4cf88abe6cb97c0071378a9893dcc51e229' ;; \
    x86_64) natsArch='amd64'; sha256='26369e1f077d68b93ca00ae4d37007e3ee2db525d7d32134fcb4035f461b4f8f' ;; \
    x86) natsArch='386'; sha256='e35e8932a49b2dfb30603083eac9638136aa0b9f37d467372f014da434d0607f' ;; \
    s390x) natsArch='s390x'; sha256='40d56c09443115fde79342b626eed8af19662b7e89ac8d318b469b8b77abb17c' ;; \
    ppc64le) natsArch='ppc64le'; sha256='5f1b90a4d4bd4702c9f7574444880a8551471f1e9af0dd1e067ee56962e770ee' ;; \
    loong64) natsArch='loong64'; sha256='151acacc30a829fab3f4ed8327ce6380af25994d59c05c23ef4e75a0d415cd52' ;; \
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
