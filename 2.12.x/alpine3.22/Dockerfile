FROM alpine:3.22

ENV NATS_SERVER 2.12.3-RC.1

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
    aarch64) natsArch='arm64'; sha256='24bd216510f8512f9e0da98f71cd07cfbf91e7b44f77f5a0be9651cd6434ccc3' ;; \
    armhf) natsArch='arm6'; sha256='adc3747340dd71a593b44dfb05b23be03fe9eef59161dcc463a98bc972f1e46d' ;; \
    armv7) natsArch='arm7'; sha256='1bbf0c8985b9fd79af1688447fdb4d19befaf93381ccfaf50da6b380dc8389ab' ;; \
    x86_64) natsArch='amd64'; sha256='c6f519c328cd256c120c9ed087c6638f3c7f6dc51f4d602b39adcf6ac4ba8bad' ;; \
    x86) natsArch='386'; sha256='988fe45a68ad4b99606e3dd8c47acaa4effd8f985082af45344db37c6dfd72a3' ;; \
    s390x) natsArch='s390x'; sha256='2466b95c7ed0157bbbdaf87213826cdbc87f15e7479361a18a293ba1ea2be5c5' ;; \
    ppc64le) natsArch='ppc64le'; sha256='11a652749dcf487def65fd0c1dd65e24ee70d945bcb7b396d19be538bce730c6' ;; \
    loong64) natsArch='loong64'; sha256='7214e6b2cfcb3fd0bfe00bfdb8db83158849d57f9d36facf63f31e08d18b7525' ;; \
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
