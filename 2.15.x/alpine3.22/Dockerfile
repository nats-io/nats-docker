FROM alpine:3.22

ENV NATS_SERVER 2.15.0-RC.2

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
    aarch64) natsArch='arm64'; sha256='09ed93686160813374a960f0b4c904d108346281c02b50fb8790b5e958cf6b4b' ;; \
    armhf) natsArch='arm6'; sha256='fefbb1736a44837a0d84a8887e9be51eabd9bc16a202490503736a370c63fc12' ;; \
    armv7) natsArch='arm7'; sha256='db8efd526e4a99a2c8a1eaf9d963dad543512b6346e0317bdbd4e826577d0ff6' ;; \
    x86_64) natsArch='amd64'; sha256='1fb97433260bf50c7b24205ae677d0b62b0034971c34dacac9437dec1be1cece' ;; \
    x86) natsArch='386'; sha256='daec8b02c9c6573326b52a9c1031f5d7811ccc054803838c4ed91e96f28456a9' ;; \
    s390x) natsArch='s390x'; sha256='93c35736d148bd895134d247cff797ee150155954736dd64989ca8af694f8f0e' ;; \
    ppc64le) natsArch='ppc64le'; sha256='69fd69a08d2d8e6224e92fb9e3b929ed0b11adb0e5685f41805319d5456c37c3' ;; \
    loong64) natsArch='loong64'; sha256='8fe92c12f3c1a4bfd161c6377e176581c403c23a2d13d6d4338846c2dda3f251' ;; \
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
