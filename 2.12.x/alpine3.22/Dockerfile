FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='dfe58d626f74a791a0f15cac99be73cf6279e28290fd2e52a4ba42924b6af5f0' ;; \
    armhf) natsArch='arm6'; sha256='d9b336f53a56b549b5ee860c8b2f41a6dbc8bb004cc2d0b5d413bde6e12961d8' ;; \
    armv7) natsArch='arm7'; sha256='966a55e60661df5075f0ed8eb0adf462b12754bf37805f3c8f5ea924e0e91519' ;; \
    x86_64) natsArch='amd64'; sha256='4efe3a6009435eb7ad6d9e5852275daa94d2cea510363bb079ad1d41b459770b' ;; \
    x86) natsArch='386'; sha256='3094e7641e9bbc64fa53abe98e92febf43e09756bf0ee5a79051511199e709f7' ;; \
    s390x) natsArch='s390x'; sha256='ec9c81a9b25409b369039395a7b63b5724a3cfe15fb66068b939a52cc8b0b817' ;; \
    ppc64le) natsArch='ppc64le'; sha256='99674f295a567e313bb18e1433a7beafdc11e8f73587234168b03168f92586b3' ;; \
    loong64) natsArch='loong64'; sha256='07e444c94eee034760c4298a6ae23d046c29a346b676a273704ba16862953fc2' ;; \
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
