FROM alpine:3.22

ENV NATS_SERVER 2.15.3-RC.2

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
    aarch64) natsArch='arm64'; sha256='5676e020a4cbfbdc93ea8087537d4f392e30da9d0edca9aaf4004f1c8e1895ad' ;; \
    armhf) natsArch='arm6'; sha256='8125dd5a932a80b9420ed5a52bdd790ad00c2d3aa3d08a01bfdb718e71b041e7' ;; \
    armv7) natsArch='arm7'; sha256='f0a2e452dad849b526e8092df156d464ede5d4e7604207cae440f612f5b9b35a' ;; \
    x86_64) natsArch='amd64'; sha256='8c0370f588f5d66f5e706b21b9e1f9bef8e8f8438a3771b87cb868eab736d6c0' ;; \
    x86) natsArch='386'; sha256='4cac6d18aa9ee10e3e2277dae332be706672790f74301fe7eca2edc44da33279' ;; \
    s390x) natsArch='s390x'; sha256='9b4699d6a7b74da6265ee9de64e21ead72ccc3843adcead4434a40aeb5035af0' ;; \
    ppc64le) natsArch='ppc64le'; sha256='8ace7f1f105e2a5b596204c97ee7d42c1beaee0f0470fb43b4cdbda0bb7e7112' ;; \
    loong64) natsArch='loong64'; sha256='7022864fb83b25553a0800423e2d8875d0be57e5cc768eb82f05ce916e9018e9' ;; \
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
