FROM alpine:3.22

ENV NATS_SERVER 2.11.12-RC.4

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
    aarch64) natsArch='arm64'; sha256='9e367da750443974f078cebfea8b466c3c59430c30c5853884bf46cd35f260b3' ;; \
    armhf) natsArch='arm6'; sha256='1d3b0633a6f53ebae822b2d409bcb671e14a7243f55fb81b792b03cf6e73a822' ;; \
    armv7) natsArch='arm7'; sha256='3b1a31b7da4caa12b538a4da480274631f0deff8bc4045dfdbeec3b9b3fa04b6' ;; \
    x86_64) natsArch='amd64'; sha256='63764ac43bad6c118578c08449353687d282d84dc0a2d057a6806648042737d7' ;; \
    x86) natsArch='386'; sha256='ea7675bf703f1ca311c0688fb8ebb84502c874f61d43532bcd245cfd6b4336e2' ;; \
    s390x) natsArch='s390x'; sha256='20b8cf0df61d10316495fccc57489c346560bbf7fd4457782b8827ff24c92b46' ;; \
    ppc64le) natsArch='ppc64le'; sha256='818f3fbe7ddf6214969766ef60ba3cf62f21c37ffa2c97555f4836594117b28b' ;; \
    loong64) natsArch='loong64'; sha256='136d51afd4dfbcbd8e3f55995ec8b85659f7cdae9da9e4a1b096d0d2f01739d9' ;; \
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
