FROM alpine:3.22

ENV NATS_SERVER 2.11.14

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
    aarch64) natsArch='arm64'; sha256='b3a18f49acd75101b8d42671b11c2a4e671175cf90e52f1fe73c70ca02b6c8f9' ;; \
    armhf) natsArch='arm6'; sha256='db1ddf3f0cb7d0374d553b06da3a5f805e73633d34bb767099dd8ffd1775992b' ;; \
    armv7) natsArch='arm7'; sha256='a4ba6f0ee49d1ec270766d20d9003f9e9de2d91d8fdd3b04a1464c25a28a1798' ;; \
    x86_64) natsArch='amd64'; sha256='1e8843593565abc7e3280238a2648537805025d1cd66244bf884ac3b45a6e3a8' ;; \
    x86) natsArch='386'; sha256='50cc562791aa4bcbeaf72c4bf6b2a42dc67da68aede7a3c495c5b65370b7bff7' ;; \
    s390x) natsArch='s390x'; sha256='6d5efb93403b638522b1516b425497c1220df112f6b2bd4c297772e0fcf2c2c2' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b8c08c856990f5e1d038dcb91a652ae68815c227654493bca714be8bf92c622a' ;; \
    loong64) natsArch='loong64'; sha256='630f7b7001155df394df403629be602067c1746703a54a4378e7bf57dd190990' ;; \
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
