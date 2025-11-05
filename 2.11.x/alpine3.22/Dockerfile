FROM alpine:3.22

ENV NATS_SERVER 2.11.11-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='a968f26eea7459b364432a22505398737ac132b208c7b1411072c37c3754c5b6' ;; \
    armhf) natsArch='arm6'; sha256='283936d593be5a4177eefa439609a31c235769d0ef0446596b7a86d500da76cd' ;; \
    armv7) natsArch='arm7'; sha256='de33a925c30aa7f7a3c478e2e35969d7f37af456c0cda0419b9d85a9a27d4996' ;; \
    x86_64) natsArch='amd64'; sha256='8ad10f8ab76988183601765ae6895bea5564c8d9d886cc668ee3f0b0b23a6f9f' ;; \
    x86) natsArch='386'; sha256='017a3c3647c3ff8f0a5fe06f493d1de6e4deffd158b44fc88dce1c5c1195f029' ;; \
    s390x) natsArch='s390x'; sha256='6547bd7cf3df56efce1b0e165d2f5375184234d4c57b019a4035e88214279194' ;; \
    ppc64le) natsArch='ppc64le'; sha256='2aedc960ca94986da43ff9bbd822b56f7c6f267cf8295daa4cb27a91a7af5e8e' ;; \
    loong64) natsArch='loong64'; sha256='18ec1d5bd07b5fdac8b75b76a7a832a17b3ea3a66ede62958ef3c87ab862cf39' ;; \
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
