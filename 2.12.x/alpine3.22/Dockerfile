FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.5

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='5bd9e1b0af22583ced744c97c5b1056621ecd87e4aa93fb6231c761a4aa68456' ;; \
    armhf) natsArch='arm6'; sha256='9db3da97e8d1f1f9e4bb5db564d8b7dadd58f62024046e9df55d9a6bced88edc' ;; \
    armv7) natsArch='arm7'; sha256='d1a7d2a2322a6f32df649d14cfafed28afba399aa443980477b744508540cdd9' ;; \
    x86_64) natsArch='amd64'; sha256='c94ca006a883464d30fcf3f4b31b36cf338f375293d1273eb085889cce0370d2' ;; \
    x86) natsArch='386'; sha256='e99bc7e0be4ed605781780a0c95b9b9ab351485e90bd6839c83d730aa2278b86' ;; \
    s390x) natsArch='s390x'; sha256='206ca264b03e33985bca432e181feab964792e5ce7a22249fdee82328b4633de' ;; \
    ppc64le) natsArch='ppc64le'; sha256='9da86e77eab040dd9b7fba57875736bf4537f34c237bbb45c141b66044a0faf4' ;; \
    loong64) natsArch='loong64'; sha256='ba3af32f438b18b2f61a69928ba17c42c0fcc998780d7adfd446900ee98cf243' ;; \
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
