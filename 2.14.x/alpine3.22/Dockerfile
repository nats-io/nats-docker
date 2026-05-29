FROM alpine:3.22

ENV NATS_SERVER 2.14.2-RC.1

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
    aarch64) natsArch='arm64'; sha256='bb68aec52a8f4602ab6ddb1a5663444e9738973df386b4c8ee6acefc1add49d9' ;; \
    armhf) natsArch='arm6'; sha256='bba476653fe93099b18ffcf9b8aa0a77a0b820c48e5d69e282bc88cc0e45ec46' ;; \
    armv7) natsArch='arm7'; sha256='7176ca360d41253fd76a04ae073d693153cfe40fec9e842a70d642642a393fe6' ;; \
    x86_64) natsArch='amd64'; sha256='873297db8d8b87c262c5ae7cd1378c770b01a395c1ea501de2fffa8bc5bc00df' ;; \
    x86) natsArch='386'; sha256='b88190f342ce0c41601be406bc5730bbabcea55b9564ad059f7f37d072bbe95f' ;; \
    s390x) natsArch='s390x'; sha256='03fadbbc797edc6bb68c3922fc4989e6427ecffa3ce1ab5fe0e6391f887eee81' ;; \
    ppc64le) natsArch='ppc64le'; sha256='7d26a7032d9e085587c7a7198a8aee05e4702ece8a3df549d5268e2e11805e19' ;; \
    loong64) natsArch='loong64'; sha256='1accea1c9ece2af7c57c0f725a1c08c52e94f04fd5767fb9be781bfbf1bab493' ;; \
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
