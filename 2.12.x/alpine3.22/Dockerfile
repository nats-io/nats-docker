FROM alpine:3.22

ENV NATS_SERVER 2.12.10

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
    aarch64) natsArch='arm64'; sha256='33503268e1c2ef81a6b6f7c7b7d04ba74ded7072b57cc7e32b2bcefe73954e18' ;; \
    armhf) natsArch='arm6'; sha256='0564238518580288e49778b54aed7b348f4bf4a23ae45a817780eca955e48018' ;; \
    armv7) natsArch='arm7'; sha256='cd37c5a380c5764367e9f48378aa9c2db2d8b56ec625f546df3c2b24ac4302ad' ;; \
    x86_64) natsArch='amd64'; sha256='fd361ae17787e279c8262ea456dad0b1de3b0d3d7f9e94725fa3098626490dcf' ;; \
    x86) natsArch='386'; sha256='51433f2d42fbf1ace6a59a7df3f4ff367683053959496664a0f476c8a148f67f' ;; \
    s390x) natsArch='s390x'; sha256='ba62c43fd9946d0de2aa58ce07b656afa44a54594396f4b49343dc05b2b4ccce' ;; \
    ppc64le) natsArch='ppc64le'; sha256='44b5e25037e3187fe1a686da375d4fdfa7b074db77928e2865fe28c7d76227d3' ;; \
    loong64) natsArch='loong64'; sha256='f4f928d19e886f7521b22595ba9c4cf1391291f3945d123b8f026f3568b01504' ;; \
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
