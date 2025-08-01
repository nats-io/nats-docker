FROM alpine:3.22

ENV NATS_SERVER 2.11.7

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='8444068fb823a96fd16ddda958838bae22d56a97e3537cbbfca63ab6da090a26' ;; \
    armhf) natsArch='arm6'; sha256='c13e77da492ee9c3ab13e0ec949c950933b71539b07250d1de6afd62447c2cb3' ;; \
    armv7) natsArch='arm7'; sha256='a5d598665bf0816b9a2033d6353a69e9740e79b07b3fde65bca085e130b46469' ;; \
    x86_64) natsArch='amd64'; sha256='9a5fe725b3c62df50bb37e2f8527f8f2e97ea3f38e54cff0ce9b9a0d9b5f67c1' ;; \
    x86) natsArch='386'; sha256='297bf656b991482f796b4c34a573bfba41bb83fc3234bc9a7d0157ab4ef600e8' ;; \
    s390x) natsArch='s390x'; sha256='f314f53518522c48dcf422dadd603bb2815fbf91c51e9b08d2ba0acde184a40a' ;; \
    ppc64le) natsArch='ppc64le'; sha256='aef74901c2cd215d399bc83b9be77a9917592398a34159d1372ca5301c8d962c' ;; \
    loong64) natsArch='loong64'; sha256='8c524d1a707c6b3b7b3aaa986f418f9bc16411b17f00c5709a62160b045a3265' ;; \
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
