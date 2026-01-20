FROM alpine:3.22

ENV NATS_SERVER 2.12.4-RC.3

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
    aarch64) natsArch='arm64'; sha256='8f9c6b6acc0179a973a3d021e6138fc105437d6ce03a7e646271e0a289d93de6' ;; \
    armhf) natsArch='arm6'; sha256='42cb53e54e34f7b4036f426192e703f2693a667eeb7a0afcd85774f689fdbfdb' ;; \
    armv7) natsArch='arm7'; sha256='eb35682bc45712609e69fc931c1d91bf0c7acebc2c765d92b775c6f5fd4dbee1' ;; \
    x86_64) natsArch='amd64'; sha256='3b7cb95a1bd561ec7bd62cbc696812e273f7944cf447d20a0048450a234a5f85' ;; \
    x86) natsArch='386'; sha256='a001ac2c871147ae8c12b02eeb687f01194939f5722c455f4c5f20e19b903ebb' ;; \
    s390x) natsArch='s390x'; sha256='fb9d1a473aff7bebd024f8da2809d05da22cf3571e667e76cd595e2fa947d819' ;; \
    ppc64le) natsArch='ppc64le'; sha256='63199e53eb855f869da7d91dd9148b45820c668cc9938e14ba76aa52b3e6335e' ;; \
    loong64) natsArch='loong64'; sha256='03c6549377be67f340b5419e5f4572632c12d304a16e78c256e4fc2ca2f6be69' ;; \
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
