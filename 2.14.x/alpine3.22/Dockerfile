FROM alpine:3.22

ENV NATS_SERVER 2.14.7-RC.1

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
    aarch64) natsArch='arm64'; sha256='0394ac4951178c0bf44be89ecc7a307ad2e090abc81bb8dd615e0f3a868e4311' ;; \
    armhf) natsArch='arm6'; sha256='0b2861686b5aa702a53fb3dfaf14a61a7e393f41b777bcd30fb61a3280e1e136' ;; \
    armv7) natsArch='arm7'; sha256='247ccc1b50870212b661b8e4407c4cad3ff9517f8530af43825488314a6f5ae2' ;; \
    x86_64) natsArch='amd64'; sha256='4ffee967460966bbb67fcce668335e8bafeaf7b0923b30d5e0e92981dcde4fc9' ;; \
    x86) natsArch='386'; sha256='82e1107f1b13b856d00bedcf33c420b842f16db002f147a6283ca07ad9a92299' ;; \
    s390x) natsArch='s390x'; sha256='84c7c0743e95b51dad7696707ae548df828e7e10471453d58790daa0de288fe4' ;; \
    ppc64le) natsArch='ppc64le'; sha256='bb746cb68395043f3a1cead20e96e315180bc5448a01af78a8e4db80896cbff9' ;; \
    loong64) natsArch='loong64'; sha256='99ad05d65f81eaea4571cc93d592e208e3db03eedf2c498d441f413fe81f6c07' ;; \
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
