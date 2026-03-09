FROM alpine:3.22

ENV NATS_SERVER 2.12.5

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
    aarch64) natsArch='arm64'; sha256='85caf0500b011a31b105fb04992cb350236e2d5935a4d2ea7cc1efe9203aafc2' ;; \
    armhf) natsArch='arm6'; sha256='71a4b194ea3c093318fefb30f5aa9bcbc2b25b172ecb9f17fc9ea18b9c4c7f67' ;; \
    armv7) natsArch='arm7'; sha256='72f0084970ca9605b83db78806717403e1f676a587a4a07bb28a4b86ae201bc6' ;; \
    x86_64) natsArch='amd64'; sha256='f1967bea3fbf6c86273f1a2edf5be65165d795716ae1ac2a14824f19cdc35c20' ;; \
    x86) natsArch='386'; sha256='5549c7352ff3b04424c15402656bccfc5bc3fb26433e0b092ee794c1eae00c8e' ;; \
    s390x) natsArch='s390x'; sha256='ca7235acf15b59d0b29d413ecb2a3654fa2a877d0a5f6d91db28dbc2d4064ad8' ;; \
    ppc64le) natsArch='ppc64le'; sha256='29cc4c2566e960a85d2b277b99bf24322ce5c3e3da6e197eb253beb372e9839f' ;; \
    loong64) natsArch='loong64'; sha256='b126457f298c58981fd42f21bff7c9a37e992ab5727862af64b41aa68b0d8d3b' ;; \
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
