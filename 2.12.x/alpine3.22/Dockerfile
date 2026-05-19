FROM alpine:3.22

ENV NATS_SERVER 2.12.9-RC.2

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
    aarch64) natsArch='arm64'; sha256='c311972f10ffb5566af9340b9ce52a94dbffa0caf809a4eb78ef0ac425de7542' ;; \
    armhf) natsArch='arm6'; sha256='f6ef994e1478b0281ae1feb0ec2b28258cd2bc5afd29dc6f78f574ac4ed5cb1f' ;; \
    armv7) natsArch='arm7'; sha256='2635a459cf5b28b9fc55c5597a40c51061beeb49ed16618f42f6fac795f7600f' ;; \
    x86_64) natsArch='amd64'; sha256='9931eb30745e6a18e0a166f3daae21251edc312944ef96cb99811112a85f83a2' ;; \
    x86) natsArch='386'; sha256='f50e2966627f19076cee2b044d31127e089c84aec7d7f4c4a8d91f18095c6e91' ;; \
    s390x) natsArch='s390x'; sha256='8c45cd88ff384f9fed8ea7f74af757a1e3ed77d5789b756d395bc1aa07fdc0ba' ;; \
    ppc64le) natsArch='ppc64le'; sha256='09a7f6e4f13551b543644ac02d7f7c4362dd5f2c8e862601d42264eb24eef071' ;; \
    loong64) natsArch='loong64'; sha256='52246e6bb2a6a56acd477fb448c778b7df61c1513fffa3b215250b7332e36952' ;; \
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
