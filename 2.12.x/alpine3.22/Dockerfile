FROM alpine:3.22

ENV NATS_SERVER 2.12.2-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='1e6282d95d9d209f3dc987b19a245a26ea419b1bae8cbd463d77905e380e6ea0' ;; \
    armhf) natsArch='arm6'; sha256='955aadf29e8bf2ed7b8fedf9fdf80bce8c91b1058743377c490a10614f0fc119' ;; \
    armv7) natsArch='arm7'; sha256='9cdb3e00fbdc1a8f689d448d5162c61d4152bdff7383a59256be91968ee99325' ;; \
    x86_64) natsArch='amd64'; sha256='9b95c62fd1cc46581d139fe03d424f8e2d93949355c412b3a08c54a3795e05b9' ;; \
    x86) natsArch='386'; sha256='098bc68effe5aef8c15b31225ed913deaf455380700f17e1c7ebb00c727bd150' ;; \
    s390x) natsArch='s390x'; sha256='bb52f57889cbbf1a9f593ace5eb80a008f032951924866b5f8ae0ce7c3d2f8eb' ;; \
    ppc64le) natsArch='ppc64le'; sha256='707038faf29c158f79fd658a5815eee99b86d51cf31b79f16c44599d7f7f3082' ;; \
    loong64) natsArch='loong64'; sha256='7639391971898129c269275a8f60ca20f431a0435626f370cad981112a3e2931' ;; \
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
