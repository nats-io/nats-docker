FROM alpine:3.22

ENV NATS_SERVER 2.11.9-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='bb3cf128be03636212b0e28a97be1841a093cbf391a5627506a135797e7cb572' ;; \
    armhf) natsArch='arm6'; sha256='bcee55d477384bb9572b4113090fd71d01e8587b31cdc8255e8dcc4b5985e634' ;; \
    armv7) natsArch='arm7'; sha256='6f6b361b2b65e336cfec42c8dea08a09c9cb51424bfce776d8fa60825804e0d0' ;; \
    x86_64) natsArch='amd64'; sha256='4fe8913a4a4cd29adf49d444166c32dbbdd75f99ed10d21492efbf671a199567' ;; \
    x86) natsArch='386'; sha256='5df5a72fa2fcad2ac4e7258e6fb3edd46b7557f85fbb36a4fdee999eb26d47e0' ;; \
    s390x) natsArch='s390x'; sha256='cc2e73e22690467a11cd82022748720c97d7ebe7a264fe232cccb643c3b93017' ;; \
    ppc64le) natsArch='ppc64le'; sha256='5ddfe00b460192512bcbdfcfb10781a543b27b7f14bab89aac652d6dd07d754b' ;; \
    loong64) natsArch='loong64'; sha256='abe577d704510186c36f4e49d521b2a19c6ba0c08f19f0e37b42477dfcac1164' ;; \
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
