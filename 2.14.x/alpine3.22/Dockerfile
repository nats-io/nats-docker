FROM alpine:3.22

ENV NATS_SERVER 2.14.11-RC.1

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
    aarch64) natsArch='arm64'; sha256='b23c3971fe771f13399bcb3db3a8e8ae0d65ac7d28c8a0e4d8afbe43983289f1' ;; \
    armhf) natsArch='arm6'; sha256='a744f745a21bcda687167de04ae9ab126ddd32eddb33af771dbcbb4058e91feb' ;; \
    armv7) natsArch='arm7'; sha256='b81c935fb750be556e318e2b7c433df0a230ab56c8392dfd99fe3a0912f19e21' ;; \
    x86_64) natsArch='amd64'; sha256='4ee76142e560b41920c288861de698eb2cf56b15d8d3ff78c88ab4443f027cc1' ;; \
    x86) natsArch='386'; sha256='b7739c60c8a5dc104a3e7c13065b98d00eafa941146005edfdfb86e9eae35464' ;; \
    s390x) natsArch='s390x'; sha256='9ca41ce3fdfbff7a1f7714f30166d05ae5ac3efcda0e4dba0dd13ea590d70bf8' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d18d9d4a3b46a98c40f2d27354d1479cfa8617ff7360db0a2fac54bb031d8259' ;; \
    loong64) natsArch='loong64'; sha256='82f16681c95af266055a0a4293d8cbcc16afc446fa6729937178321e512b708f' ;; \
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
