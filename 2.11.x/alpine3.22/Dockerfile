FROM alpine:3.22

ENV NATS_SERVER 2.11.8-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='738dbf233f0cc77351d6d8112e16520a4b572e8c8f721e225e928fa7c6d44b6b' ;; \
    armhf) natsArch='arm6'; sha256='0a9fd97f667c89f48de404af05f8694cb2848e27e3314c045d020bb52091ed5d' ;; \
    armv7) natsArch='arm7'; sha256='735663c2f13934edb873ae9a627dfaf6221af7f2101e8380c0c3f1e9cc8ff6f2' ;; \
    x86_64) natsArch='amd64'; sha256='2d24188bdbba3ce00d406b822e8fe195be6c79c3157c8841dd6e2be8a223a0ee' ;; \
    x86) natsArch='386'; sha256='49e43543a3cc0ff8415753f2688a7d29728ce6d702f99f132a6cb0bf82eed91b' ;; \
    s390x) natsArch='s390x'; sha256='3d014a2c5770aa68e803ad512c47abf0ae573e82c7141a3d404527c9583f89e3' ;; \
    ppc64le) natsArch='ppc64le'; sha256='267c2511772b7e9a1b14a1fff6bbd11a0dfbc51714d6952a321d28e502fbfbed' ;; \
    loong64) natsArch='loong64'; sha256='3cd03819e3fb2b00998630aefcb1f8ea3913e5954fefaa1e47881523cf569f8e' ;; \
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
