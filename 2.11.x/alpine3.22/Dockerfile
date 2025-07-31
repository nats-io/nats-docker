FROM alpine:3.22

ENV NATS_SERVER 2.11.7-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='0293ae2bb5c7b72f2d74c8d0bd751a53d7e4ccea5d72cfad21676215dbf99aeb' ;; \
    armhf) natsArch='arm6'; sha256='63df1821186994207f97b0bc1dd68544d18aa79c5c16c5ad8e076ddac6eeb83b' ;; \
    armv7) natsArch='arm7'; sha256='117c591e28c96907c979a95f2192a06573b548d5ea5d924aa0d164b4fd4f1b6b' ;; \
    x86_64) natsArch='amd64'; sha256='cc93b906dea44f771f423e680c4b72d1f54159ec29b4087926a809bbff6efb56' ;; \
    x86) natsArch='386'; sha256='d716572e58a8a3f3e8a847961df5744c519bfa7fbd7bb1e79e5d243f07b64566' ;; \
    s390x) natsArch='s390x'; sha256='ab68cdb1e1c07fcafcbaa57fcc3c7c35e02d89da5fffe3d7b021b1780f86c11b' ;; \
    ppc64le) natsArch='ppc64le'; sha256='736529cc950e825f32f671b16b77c5ec8505bc29e6491e7103667195d0faa75f' ;; \
    loong64) natsArch='loong64'; sha256='2597f2442fc59b78b20712c99a1155a1980c31755bcb1e427a6643deb236d0c4' ;; \
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
