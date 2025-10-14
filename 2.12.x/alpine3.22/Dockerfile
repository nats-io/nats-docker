FROM alpine:3.22

ENV NATS_SERVER 2.12.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='1e31b395fbe6443d54a70cedb3f66d6871525a7c9a9862ebdfeb55df7158ecc7' ;; \
    armhf) natsArch='arm6'; sha256='ca91473ad73c9ebd37acc7bbd474ff5b096f83154b2d0b0818d11672f190ba79' ;; \
    armv7) natsArch='arm7'; sha256='6d552678cf4356bc9425217da52da1fb7297c7905e3a0195d39b7613644cc1be' ;; \
    x86_64) natsArch='amd64'; sha256='a104163114e292f90233afd8cf2bd745d2f04d53948db987ad018735449a2232' ;; \
    x86) natsArch='386'; sha256='11280ada17d423b0dc512940d3576053bdd9d34aa3ed120fc50e127e1365e094' ;; \
    s390x) natsArch='s390x'; sha256='48e97b641705009b6ccd7aa78a94fbe22fef114a6c1822b38998ada4cf837060' ;; \
    ppc64le) natsArch='ppc64le'; sha256='80c09ad7b7abc76aca55c00b4f05ff80e42ea1b222f298265c21792ada5949a9' ;; \
    loong64) natsArch='loong64'; sha256='6e30e0e9b93dea35713b07cc89ec291d6cd2386d02aa9ef2d46f288695708d21' ;; \
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
