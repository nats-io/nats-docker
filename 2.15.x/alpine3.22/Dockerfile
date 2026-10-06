FROM alpine:3.22

ENV NATS_SERVER 2.15.1-RC.2

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
    aarch64) natsArch='arm64'; sha256='ca8753dcc224a825d4ac3bad3ae7365d5e26631da5c0f1a907e5a74c833c3e98' ;; \
    armhf) natsArch='arm6'; sha256='fb30117e2811f058691a16b4fdf02479e1e44923908e6e5b1da31d198cb2fd9d' ;; \
    armv7) natsArch='arm7'; sha256='058a1c8f0205768f2a44b204d2cb2f28349292b7b359c83ee9b498d3acd3139b' ;; \
    x86_64) natsArch='amd64'; sha256='dd06a62105e77a1650f65bb8ee65e98b7d049a35e4e3600c2f96b0d37c984ef1' ;; \
    x86) natsArch='386'; sha256='dfc4ca98f4ca966eeaf785ac2a71000f8e8ab0788c0505b03c9f8667fcd34d45' ;; \
    s390x) natsArch='s390x'; sha256='af1da6c9194baa0471d8430506b23de9c9e79c53bc373da8f8b8c1432719d122' ;; \
    ppc64le) natsArch='ppc64le'; sha256='f552d024ceffdebc84d308051f029087eba4abd8fdd1b7c6a07a683f306794fb' ;; \
    loong64) natsArch='loong64'; sha256='9d9014e406fddcbee5364a82241cd16ce76878d32e763b36f5496a3fb3b9c882' ;; \
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
