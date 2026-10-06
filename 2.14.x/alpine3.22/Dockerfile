FROM alpine:3.22

ENV NATS_SERVER 2.14.8-RC.2

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
    aarch64) natsArch='arm64'; sha256='ea8066bd3ae54caabd9b743a23861b2041c43bdc2e351e7e90c30f62041f6aad' ;; \
    armhf) natsArch='arm6'; sha256='bc948be349c03a3f511f7aefa41dcb370a32c56f471b9b6a650da80bc0b6bf77' ;; \
    armv7) natsArch='arm7'; sha256='b38b2440f4565e3078690eb29ff9ba5f1219011e77240f4551b12a88e0320a06' ;; \
    x86_64) natsArch='amd64'; sha256='e55289cdf636683bbc87b355f050867b1c18522b9aaa72846946bfd6df752f32' ;; \
    x86) natsArch='386'; sha256='88faf9789aba0ae9f20668f961ce0b3c1d87a3a5c21d08bc95ab2e9ce681697d' ;; \
    s390x) natsArch='s390x'; sha256='a3834b3e96126c31cc839d8f385c9caa9b667426d980beb56ec7f670b023b05d' ;; \
    ppc64le) natsArch='ppc64le'; sha256='31a32fa4565d87224abd08dcc111282afda950c7aca4f1f5a60762dbb73e09e6' ;; \
    loong64) natsArch='loong64'; sha256='ed5951dac29d1b8f891ea11c3c20f769ce129dcb05fb2776a16ae5b8289f06f4' ;; \
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
