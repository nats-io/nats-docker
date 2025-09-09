FROM alpine:3.22

ENV NATS_SERVER 2.11.9

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='47d7e652eb761d771bc42df04924aae0acf4e026d30ea98faa9bab216cc2e742' ;; \
    armhf) natsArch='arm6'; sha256='70775a662c5a9f5935845b1efb08911089f796d096ad2b2d42b765cf4c3d77bd' ;; \
    armv7) natsArch='arm7'; sha256='991ed42c5d4d40ff44658fc88450b7467c99eb392ccee14e53f3d8eddeb44245' ;; \
    x86_64) natsArch='amd64'; sha256='3eef83faa048d3879937a6871f59ae5d9c3bbf5900905b7a9ff996a894d755ab' ;; \
    x86) natsArch='386'; sha256='035fd051433d2e0282320ba5da4ef09bec0b6e8c5ea95bced4ca1e72b4a1918a' ;; \
    s390x) natsArch='s390x'; sha256='1e94dc439696af6ad49e68049d2945b5521732db7ad943aa3d4442deb8f4496a' ;; \
    ppc64le) natsArch='ppc64le'; sha256='a48a7f3ea2dd7336439672c3198d24beae42bcfa6291140b40ca44aeef9eeaf9' ;; \
    loong64) natsArch='loong64'; sha256='1f8de18cce53631d1b73fe4ad7d332e1741523ae725a0d913983c81c9798d2e6' ;; \
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
