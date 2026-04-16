FROM alpine:3.22

ENV NATS_SERVER 2.14.0-RC.1

LABEL org.opencontainers.image.title="NATS Server" \
      org.opencontainers.image.description="NATS is an open-source, high-performance, cloud native messaging system." \
      org.opencontainers.image.url="https://nats.io" \
      org.opencontainers.image.documentation="https://docs.nats.io" \
      org.opencontainers.image.source="https://github.com/nats-io/nats-docker" \
      org.opencontainers.image.vendor="NATS.io" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.version="${NATS_SERVER}"

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='6343be1f5397839147a70e94d300565d1de62a5dc7962d9713225b5956a4b000' ;; \
    armhf) natsArch='arm6'; sha256='516b163798473617f4235dc58ce324ca907319bd7df7867900bea3940a7e7c1f' ;; \
    armv7) natsArch='arm7'; sha256='159632a2a1607dd1be605436d4f82a7aafc0e13eff5be2a657916a23777de8f9' ;; \
    x86_64) natsArch='amd64'; sha256='5caf8b2d6e280faa564ff014d5071f708bb376f35e6e951f8420659d9e7ef93c' ;; \
    x86) natsArch='386'; sha256='a63a1dc74af0add6a9f190a7e2765b682604220bde9b41d00268217e7c2c19ee' ;; \
    s390x) natsArch='s390x'; sha256='bb3838ef25391bb14f35eb8945bf439963fa5a6d3b86ac5ae4fec14eb1e49201' ;; \
    ppc64le) natsArch='ppc64le'; sha256='0defb8202df97d8cc43292504262a80d5ff968ef52134c44e95a8f3096790d08' ;; \
    loong64) natsArch='loong64'; sha256='bede7079b5ec3665886ebf7e47523a9bf98623f9b897b760c26174e7319bfded' ;; \
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
