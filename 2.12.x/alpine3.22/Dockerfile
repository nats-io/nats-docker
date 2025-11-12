FROM alpine:3.22

ENV NATS_SERVER 2.12.2-RC.4

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='41ceda979ad84aedc7a7ff12e19d88128f500238fee7c744dff74638188e1d6e' ;; \
    armhf) natsArch='arm6'; sha256='4b1d79a5d8446909e9aed94f76f67f16b012bf273c013fce551d7c95c4282221' ;; \
    armv7) natsArch='arm7'; sha256='935558ab088d815b8266e9811a8a34e6986250450b6fd9518b94f31083034f02' ;; \
    x86_64) natsArch='amd64'; sha256='355ce9f1118d82b6f5e5ebf62ec7b745e1a20a80532ee5eac07c9d04937d4ec4' ;; \
    x86) natsArch='386'; sha256='198dced528de583918f25395265be4bcb295f86b4e4fe95da4b4a24aad8f072d' ;; \
    s390x) natsArch='s390x'; sha256='3b8d6bf1ec3e3a47ba4a8ef24da44a5e3cb66174b7abd74edab1294a40e4014c' ;; \
    ppc64le) natsArch='ppc64le'; sha256='8c620954a6bc4642ba86a7bbe243e51592182ee836d1e417ec0d8f46e2254f36' ;; \
    loong64) natsArch='loong64'; sha256='08e0522dc8fa92ccda7b8734585420b5f0c309b5e380a2089800ed5693125e52' ;; \
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
