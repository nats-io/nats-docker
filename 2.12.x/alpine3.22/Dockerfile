FROM alpine:3.22

ENV NATS_SERVER 2.12.4-RC.4

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
    aarch64) natsArch='arm64'; sha256='137f875394dd9ce2b15ed57c119f44ca0eec0e939e0ac71540aa5ac9497b0fcd' ;; \
    armhf) natsArch='arm6'; sha256='24d5a5f6cd6989168cbf85e51d27d54afbf5e2feb5ce3497a34c65ea34ccc594' ;; \
    armv7) natsArch='arm7'; sha256='6cf6267f2e1e4d0b2dd80863e4e93d7095b13e29c101b45cdc22ce8aaed7d0cc' ;; \
    x86_64) natsArch='amd64'; sha256='c5362221ded8d7ac50b70b317e7e3aea6df4387e2d33a67f2dbfde94feb88d88' ;; \
    x86) natsArch='386'; sha256='987bb93ea15c8d334a223c610c72dde26e33583c0bd3e57ae3782e80ba188660' ;; \
    s390x) natsArch='s390x'; sha256='567a72ebac3c22769c7b6bbc765c8e345506385d5dd29b93903678dfa163980d' ;; \
    ppc64le) natsArch='ppc64le'; sha256='43dfe8368506aa1a394daa7802d308912eb1794995de5111451d0bab81ec2b2f' ;; \
    loong64) natsArch='loong64'; sha256='b28e21238db90ea2d4a61987edebf3b63b7329d1ba278f7d6717c874710bba51' ;; \
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
