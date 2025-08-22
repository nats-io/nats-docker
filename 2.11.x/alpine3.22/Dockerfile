FROM alpine:3.22

ENV NATS_SERVER 2.11.9-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='ac6e90d1e5236d6bbf8387e8b14cacab2c0fd13d38b3627b2f6a6d2e858ca611' ;; \
    armhf) natsArch='arm6'; sha256='84f4755c28531e1a6e9fbd122997047d119d3dfc172f0d629fd9cdf14f8da8ee' ;; \
    armv7) natsArch='arm7'; sha256='2c3593132622f3c9941c1b920380c6a12af7e239d5be167489255f136c954d11' ;; \
    x86_64) natsArch='amd64'; sha256='3eab0c8ba9f02192b65219a2df28558dd7ac856c3eb02790bd418ca49893ef57' ;; \
    x86) natsArch='386'; sha256='d2adefad73f2206b821c11a689698cb46e12b839a4d23cfeebeee75ca7d8e6df' ;; \
    s390x) natsArch='s390x'; sha256='5bd18b1d85a93558501d88e6c2e5060c606070b41e7300e3354a62d441978b05' ;; \
    ppc64le) natsArch='ppc64le'; sha256='97cf4d863f773539c3714534c4e338f77ff3cc27c3d47a50f3e7e307151ddd51' ;; \
    loong64) natsArch='loong64'; sha256='47f823b4254c7e36aa307f1657750b7e99edbac981be132c61d68789ef5cd58e' ;; \
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
