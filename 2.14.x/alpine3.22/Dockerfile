FROM alpine:3.22

ENV NATS_SERVER 2.14.1-RC.2

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
    aarch64) natsArch='arm64'; sha256='3c67d8ecab00b773658cd7415b2fdc6c0fc72684ce38970772100cf96533e060' ;; \
    armhf) natsArch='arm6'; sha256='15edf202a0d47ec8fbcbda9e05e97e29026eda3b5167f169c27c31e08ded6332' ;; \
    armv7) natsArch='arm7'; sha256='4a04a5809ba271a86c5c1c0b35f72be501ced73eb0c6dff0dc47ad5acef8109e' ;; \
    x86_64) natsArch='amd64'; sha256='6c91fe20aefa6f5592d9e13a0e292b61e196e0d4254a1905bf1f5cc45013b2e3' ;; \
    x86) natsArch='386'; sha256='a91f265a9636a3a1c42023b9723447c8f92b724195ad54604a28eb287b48d94b' ;; \
    s390x) natsArch='s390x'; sha256='ad3b88fd92d61921020986c911ec8daa9e7a5ba02327a62d27d0c86f4fb761ab' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b0cf74db87fb6ecfcf74ae1bef417cfffd4caa9d6fe055b97d60d98aa21bf598' ;; \
    loong64) natsArch='loong64'; sha256='5b53d1766332665477f78d60a3e1085918228e0dcfd02250665d548aade83f96' ;; \
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
