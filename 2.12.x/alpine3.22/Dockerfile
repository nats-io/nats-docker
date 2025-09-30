FROM alpine:3.22

ENV NATS_SERVER 2.12.0

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='67051df32cd22ae830811ebb8574f431094e26a458fa7562e486b1cf37316915' ;; \
    armhf) natsArch='arm6'; sha256='23a20ef82d9437c159a38c68f6e463545aaa7085286d104398ae71f0153d4a51' ;; \
    armv7) natsArch='arm7'; sha256='82e0c757dff71c0593dc8ae45afadbf5bab5835b98134e9b2973750f9849ca6c' ;; \
    x86_64) natsArch='amd64'; sha256='42f233b3e883ff96e9fa9ba0882b958138534bc5dd6c4da7318e296afc0da909' ;; \
    x86) natsArch='386'; sha256='56eccfd5c4e9b3b31dae1bbe0c71b83cfb5a74f5990694dbc7557549df0f6c88' ;; \
    s390x) natsArch='s390x'; sha256='c1902cd6faf29babd917bbffe1b287747659249ca4eefd2d786b0502524782c3' ;; \
    ppc64le) natsArch='ppc64le'; sha256='2b7490b3b05392b69a8e55f8873a7be4663b03eecb0ca001ffcd97d1b3c91f8d' ;; \
    loong64) natsArch='loong64'; sha256='d632ed768d645c0e58b0ff52eec14ff2a51c5f8690639457d4a92747ee9edc32' ;; \
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
