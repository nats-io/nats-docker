FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.6

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='804ee5d211c56b54f2a46a7337cba83b9157f83b084a4f12a8c05344d8552df7' ;; \
    armhf) natsArch='arm6'; sha256='328df2d63fb040455e21f3937e7dbca3fd91f96c62a86b96ff336fa144ca3be1' ;; \
    armv7) natsArch='arm7'; sha256='ef4b08865602f193ec55d38f8afed4d2c0c2ad6b11f4df6f86508dbf68b779c3' ;; \
    x86_64) natsArch='amd64'; sha256='aaa6dd54792a2e06ccfe7840a4dfc2d083e56f80c99e24bae55b63c2f0e93462' ;; \
    x86) natsArch='386'; sha256='140e081c651292cdeebd31a0cfd881f5cbb6597a638c7ca06a07b33c011a64fb' ;; \
    s390x) natsArch='s390x'; sha256='339494365e8b03ad21c07c885263ac58897621deeba64a8a174a69e9eeb19d35' ;; \
    ppc64le) natsArch='ppc64le'; sha256='c6763c1e72f0f1ce46a8c9e9077144061deb8d079b5b23364ed6dcc30ccb9404' ;; \
    loong64) natsArch='loong64'; sha256='51b4e9c3354e7015dd49258011fa930a645e73e0ca4a10ff48b5f45c2dce8ad7' ;; \
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
