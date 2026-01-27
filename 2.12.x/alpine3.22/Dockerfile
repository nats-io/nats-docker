FROM alpine:3.22

ENV NATS_SERVER 2.12.4

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
    aarch64) natsArch='arm64'; sha256='44a6ff34eff7e8d0e1409dbac0b733cff7ecbb4f19388a4d0d3d6085d899f017' ;; \
    armhf) natsArch='arm6'; sha256='4e59df78e00edb75544aac70e1e99008cd97a039fad6ea1942b7986ee7289245' ;; \
    armv7) natsArch='arm7'; sha256='67e7708005b615d1b63280c752616ff8663fa8bd3e83bb24890905b9a0a4e789' ;; \
    x86_64) natsArch='amd64'; sha256='92388f2e4aa1e6dea402eb173cbdb1fcb1df9a9c899cb807b91ddbb45c131b65' ;; \
    x86) natsArch='386'; sha256='0899515b18dcbfba3572e91ea0bf7b7577a00d102ca91be44840a8a1ad68b4d7' ;; \
    s390x) natsArch='s390x'; sha256='8c084d41b8ef405c31ff75f84bb03028295001f9741724a8d0fb2c28aa0f3690' ;; \
    ppc64le) natsArch='ppc64le'; sha256='5b073b7cdfb91b30f226a687311193ce4544700eaf69fd32df2809451e9e5fc0' ;; \
    loong64) natsArch='loong64'; sha256='e58995ac0402050a0bd6a9513fc144e9f8f6bb01224fdeb5476691cad187a1c7' ;; \
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
