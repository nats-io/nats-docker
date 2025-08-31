FROM alpine:3.22

ENV NATS_SERVER 2.12.0-preview.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='ef1eac087e252ccb414749091ad76a458154ef5a44252b957e8deb881f35f9e3' ;; \
    armhf) natsArch='arm6'; sha256='75b2d9c10ca010722beb44dc1a46adccb04dad46e15e3342cc47395ffa7dbd21' ;; \
    armv7) natsArch='arm7'; sha256='834e1b9c801ce8a006f1658d06cd0e812d7a9ecb90b26d08b5c3415d6faad1c9' ;; \
    x86_64) natsArch='amd64'; sha256='3b9e5aa20a08bdfe0db3906d265852c5a11c59cbdc45e37a034ce114146e5914' ;; \
    x86) natsArch='386'; sha256='bc525cd0240e48988f98cbbf091835f8f4135d61fe63f88122d8f4894be4e459' ;; \
    s390x) natsArch='s390x'; sha256='ac5d45f1d1dc4133ee8bffa15094a0897121cf56795e14e755417d3c1b4f7cec' ;; \
    ppc64le) natsArch='ppc64le'; sha256='939e876f71ec3922577c8d755720d064c4d54712a5737b421b9f836273d211f1' ;; \
    loong64) natsArch='loong64'; sha256='eb981a939762b69f9f4e7736ec874ca051b01f1e7de97da387dd315b868dec3b' ;; \
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
