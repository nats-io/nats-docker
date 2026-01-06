FROM alpine:3.22

ENV NATS_SERVER 2.11.12-RC.2

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
    aarch64) natsArch='arm64'; sha256='02533dc01a25f642017615f66eccc779b19caa2b36e9608a8437c9156d69bbb4' ;; \
    armhf) natsArch='arm6'; sha256='c56e07187877d691f74a76fdcfc2b09bed64c501c058bbc12cd57c86b3107679' ;; \
    armv7) natsArch='arm7'; sha256='442bd572cdcf3c8b70d8b42c5cd549bb25c7597b3ae3d06a4908e491e75ac4fe' ;; \
    x86_64) natsArch='amd64'; sha256='79f9b0a3150e96c5516471b60e5c5ec5bcafe3c263c21e40e3484cb30c4fac42' ;; \
    x86) natsArch='386'; sha256='96bd8c9123f0d3f2b5487ae3c90c40e82181f3b18ff78d0d5ac8d553bbd52f7f' ;; \
    s390x) natsArch='s390x'; sha256='dd7712b3ef2214b89b399e8419a815e3502d1faae1caa1c2aacd3aff5ecd513f' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b781c51f1d20d4c199039bdfef5ada2d1271fe6fe7bc25fd69f76e5cfbfb9342' ;; \
    loong64) natsArch='loong64'; sha256='716b4f3f92c3d152fecc30e34002b31d5785af7e4ccb4bf3721c0ddeb8704d68' ;; \
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
