FROM alpine:3.22

ENV NATS_SERVER 2.12.14

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
    aarch64) natsArch='arm64'; sha256='5c7f50a6c14883a04475c6e6ed54b2091b0fa00c7022c10e21d395fdfc5a211d' ;; \
    armhf) natsArch='arm6'; sha256='48860fe19256e926b7e2f68ad0e151ab2131c0fcd4b94acdca76485f4e6a99b7' ;; \
    armv7) natsArch='arm7'; sha256='acbb66deccb4df5ac4a8c7503cd81335452c8265946d05b0ad47fd6991a81698' ;; \
    x86_64) natsArch='amd64'; sha256='84e7251f6a745e5950b9adf2159638a29fbfdcec040c13674b2362a3446b4eaa' ;; \
    x86) natsArch='386'; sha256='e1bd6e8df589757c0822f2668e8da29ce9a3deabc7d1c1c9cafdfe283192e6e7' ;; \
    s390x) natsArch='s390x'; sha256='65bbbd07a96b7cc5b51ee2263025f02c5d4e37c7a0d714e16b00042cb14e2966' ;; \
    ppc64le) natsArch='ppc64le'; sha256='404fed33fb94dc6b29b8212434e547c54b501b94541977596c87b8a47cdad890' ;; \
    loong64) natsArch='loong64'; sha256='97f70d8d6ce99fdd8ed26738bf109dd8d7cf2dd16a9745ac5f78d5ae80d32aea' ;; \
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
