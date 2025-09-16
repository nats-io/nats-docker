FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.4

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='c9720bf4a997246608f4160af6fff0e48b48af64fb290b62047210d2bd1d05ef' ;; \
    armhf) natsArch='arm6'; sha256='ff8fe99caaab8854474562fe4b01ad8db1f3aef7eaff7d6247dfd35538f8cd2b' ;; \
    armv7) natsArch='arm7'; sha256='0ec175b3c1ea0328460971c43e5b50e019043fecaa51b992c18e8d650d17c6d8' ;; \
    x86_64) natsArch='amd64'; sha256='dfd40d88ac14b590f5f970225ba7399e09ebaba16defde494c3310de8942e6ef' ;; \
    x86) natsArch='386'; sha256='c5bffca5e5091bce3344ee73766225485edf41a47e4b14eacca9cee0c56ae142' ;; \
    s390x) natsArch='s390x'; sha256='f0afcf3c45b4fce09e901c210fd324f6fd2b80ffe896b56e3d9c4ef9c1d53d22' ;; \
    ppc64le) natsArch='ppc64le'; sha256='ba1a3b58559883bb3a8c85f3b8efe9a8c920ce3d8f9eb607a741f3b750c8613d' ;; \
    loong64) natsArch='loong64'; sha256='cad7df7f8fefdc7b94f1f26c9ca5de0ce440ac977ed3c77ff9bb26d5da9c9938' ;; \
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
