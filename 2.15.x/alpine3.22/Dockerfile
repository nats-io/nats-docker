FROM alpine:3.22

ENV NATS_SERVER 2.15.3-RC.1

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
    aarch64) natsArch='arm64'; sha256='ca9d468d6a1b0b58ebe2446f700813fd5bb61ca2559d90654fed2437f687dc81' ;; \
    armhf) natsArch='arm6'; sha256='5080dc74ff61e2607b3d3ec8d4159e4bef2f7f3cd8928eebe8a26cedc198eb0e' ;; \
    armv7) natsArch='arm7'; sha256='eac71eabd41acc20814e0b1156d871fd1794e7af8e5fc97c63e6bb387b770551' ;; \
    x86_64) natsArch='amd64'; sha256='8fe61e87bfd00c956ba04cebdc98e031c9268de8301b9525d21ded8658676328' ;; \
    x86) natsArch='386'; sha256='8e9912f5ba586996cb5aef0e2e69e912f869a3140e1a7344f2f28127c0db573b' ;; \
    s390x) natsArch='s390x'; sha256='91eec87f654887668d98bee7d6ddcb0bbfa40ffbf3015c4a610a243a3fad4db9' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d638c0a3f170522a00792532573e818714a65b41ee9c2207628520245da0a8c0' ;; \
    loong64) natsArch='loong64'; sha256='f43b94d6679684b4b5b06f201b3c6078ff9a2357cd33813c92609905bfe0a4ca' ;; \
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
