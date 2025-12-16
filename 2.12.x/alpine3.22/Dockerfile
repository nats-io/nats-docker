FROM alpine:3.22

ENV NATS_SERVER 2.12.3-RC.5

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
    aarch64) natsArch='arm64'; sha256='6f4c215617fd2c40f09421f7c8499847f265b4ad5fec0c80faa57f6945fe7f69' ;; \
    armhf) natsArch='arm6'; sha256='431f6712e3625acaaf36293c3ec3e6a16a50ec2b5c49e2bfd8f6873f279fef7b' ;; \
    armv7) natsArch='arm7'; sha256='34b48feb9e6332a9532ecb7c327d12b661311a5ca8038ae071fc347af054e771' ;; \
    x86_64) natsArch='amd64'; sha256='48b4e5df7b88997bbce82963ddcae18935c4850a9a468475c081a5f44ad41794' ;; \
    x86) natsArch='386'; sha256='acb88fe6542b2be3b4bc46c7d581d8c7012509f933d9d69cbf90509a3e8de7af' ;; \
    s390x) natsArch='s390x'; sha256='be9a8c5a49bfd1369159a8c9a38fd029d69a922580998e451e33c5ee8dc81f62' ;; \
    ppc64le) natsArch='ppc64le'; sha256='223906ddfb6e7d9e3cb23c5c757877f671633717eb3e3f41b04866712c177d6e' ;; \
    loong64) natsArch='loong64'; sha256='551392fe5b28d9d40fa559ab8a8440ab258d3543bfc4b3d0916e47631b461453' ;; \
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
