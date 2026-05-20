FROM alpine:3.22

ENV NATS_SERVER 2.14.1

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
    aarch64) natsArch='arm64'; sha256='0bdd20ad850e66a484dcb126f6ce610079520b56d9e8518d099e0864ab8171a1' ;; \
    armhf) natsArch='arm6'; sha256='261accad99256ee7c7e320cac1df4fbb7fe11c28e324a3e8ae15738b6d4f0e35' ;; \
    armv7) natsArch='arm7'; sha256='15c7a984f586891bd573cf8bfa28aa453786dd7e42fa0315b2c7a85c2bdfef47' ;; \
    x86_64) natsArch='amd64'; sha256='4638c389af67d4c747f5b3e6a9d363bfe8f6b86de37d7c4ee3a36b283a5c2ce2' ;; \
    x86) natsArch='386'; sha256='851034aefaa2540951e9c6c86d144a407478da27e941f0c662f419ae1993c472' ;; \
    s390x) natsArch='s390x'; sha256='fefbeff1d6e259dfbb0a4514501a369d8c57e9d856fcc392c4da3c242162ee35' ;; \
    ppc64le) natsArch='ppc64le'; sha256='784c75d2c0430ff0dada016f36bc0ef8fef56e2117df8170eb33a37c65f81365' ;; \
    loong64) natsArch='loong64'; sha256='3cfb6bee7ec72c722b6480425edd87e96ca16fe76b31f5b8c43fae5d033c8fdf' ;; \
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
