FROM alpine:3.22

ENV NATS_SERVER 2.12.0-preview.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='09750a84296ab3186370780aead8ff32a236a9703c5216172cd15c95ebf59749' ;; \
    armhf) natsArch='arm6'; sha256='788a695813aeba84e88ff63d405c74dc60575368722be7afc5b2f4c5b910e317' ;; \
    armv7) natsArch='arm7'; sha256='e5ea23707705f8a7b82e78603f77ba9b276f28fbfa37cf2af0d4acd8bcaff5a9' ;; \
    x86_64) natsArch='amd64'; sha256='6b01efb7194e85371252cb60b8d3d743e18bb4f731eef3d93c6db4e15b274b3f' ;; \
    x86) natsArch='386'; sha256='f565f271171752f6a60f05b3f8af136c9b2c1698ea9a467ea09634b13300cf38' ;; \
    s390x) natsArch='s390x'; sha256='d70e48df89364af182d6b0e641d2e60c5b7e6fb6e29eb7fbb01d6f9cca0961c7' ;; \
    ppc64le) natsArch='ppc64le'; sha256='727095b9a37abd52afc462d8ac4c8b836f1122f6d1c65aeccbb427a1be5cc649' ;; \
    loong64) natsArch='loong64'; sha256='acfeb8c2c82cd083b6b3e1318249c06a6eabe5888ae024cfc1cc7851f6cbc60c' ;; \
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
