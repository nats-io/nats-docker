FROM alpine:3.22

ENV NATS_SERVER 2.12.4-RC.1

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
    aarch64) natsArch='arm64'; sha256='3bb3d5188da5d2d42231a7a185a258bfef7fbd1947b3674651dca39a94f7c993' ;; \
    armhf) natsArch='arm6'; sha256='14dbab5632e54687275f0d9a52c91b11c83de927621184529b22f2160f9b9367' ;; \
    armv7) natsArch='arm7'; sha256='96c33426d09d4518b8e0438d5a9638da25b12d165ba7b07da244e1148a25224d' ;; \
    x86_64) natsArch='amd64'; sha256='1585dcb838fb07b708f75ed1097f7070b55f25a24cb871a83d57d246e63b11fc' ;; \
    x86) natsArch='386'; sha256='fbf63052745e0f1a2bd5989d63760102afaa8da54b0aceb1f6d67bdfc17cbbb4' ;; \
    s390x) natsArch='s390x'; sha256='836f546ee8c027777d3e620d81ec503e581a714f7beee8a8a008a97dd2077a68' ;; \
    ppc64le) natsArch='ppc64le'; sha256='64b47480c21575d77abf29307d3db3664c751bbd113a4fd2d308430e89e37840' ;; \
    loong64) natsArch='loong64'; sha256='4af7bb5b017dee3981fa1c7ce9735fdaa65f52f2c4440fbb030f3f6a08be4c2a' ;; \
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
