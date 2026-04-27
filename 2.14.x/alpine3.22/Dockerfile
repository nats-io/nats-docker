FROM alpine:3.22

ENV NATS_SERVER 2.14.0-RC.2

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
    aarch64) natsArch='arm64'; sha256='2b0a4547306bbf4f834d109d5506bea5e3d41ec273e4338b1475501e35169997' ;; \
    armhf) natsArch='arm6'; sha256='c63a2cba41bc7e54bcd44798d4a89e4235eb5fc69a4126495893b747a3bdfa23' ;; \
    armv7) natsArch='arm7'; sha256='af6342a16f817c240da9b4b0aa6759ce103b02f02105d40b3370cddbe612f8fe' ;; \
    x86_64) natsArch='amd64'; sha256='46ebfacce48269e8c462a97a34d415991d7928620e757854cbb4285d7331a2e5' ;; \
    x86) natsArch='386'; sha256='b9561e9d684d1ce8df059c4efe6ed9d6457ddaec518ae24d3124b2f0dd8ddf6f' ;; \
    s390x) natsArch='s390x'; sha256='46c6be3b1b63970ee518b66faf441b81540963cd69df78259c99012eff96537f' ;; \
    ppc64le) natsArch='ppc64le'; sha256='ad56198ae673a3862334e896969bb2d71eafc0e51fbc76fa055338445b86cf04' ;; \
    loong64) natsArch='loong64'; sha256='06d6aff7e64700581ac9cf78f656412ba2aa42033f88e27790bf98a8128c2518' ;; \
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
