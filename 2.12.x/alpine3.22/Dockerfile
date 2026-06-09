FROM alpine:3.22

ENV NATS_SERVER 2.12.11

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
    aarch64) natsArch='arm64'; sha256='5789a9319a2ff637a24d5b11513c901515e06d7b35349651e812e5f947a04852' ;; \
    armhf) natsArch='arm6'; sha256='a0ed106cdf08e9e46b290f59364424294e97aa966444e1668369c8d9c08bf926' ;; \
    armv7) natsArch='arm7'; sha256='88a9f40d3883bac61cb078fc73559e2c59edae863d34fd8bee8cf4e26610afca' ;; \
    x86_64) natsArch='amd64'; sha256='5921d9d18c404e9565170d4fe29478dc11c164efdb3933f63001650f7c01e26f' ;; \
    x86) natsArch='386'; sha256='81efd2c17bccddb8613abd0704bfd13820fee0a589ca80db9ba0ebe7ad268ecc' ;; \
    s390x) natsArch='s390x'; sha256='99dcfb555ccf1a226ba74b62ccb3c3250e7c2fe663da12b04a5bc9b588052bf6' ;; \
    ppc64le) natsArch='ppc64le'; sha256='890f55a6aee3a8019a4fd2d59528b563ebf4a3e1e9964e85815f0f700f9bc8b9' ;; \
    loong64) natsArch='loong64'; sha256='1df8dc0903a3c700a80c85ea8ced8c15e1e6ec72a44af6f35126c1f65a95c409' ;; \
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
