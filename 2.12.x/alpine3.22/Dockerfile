FROM alpine:3.22

ENV NATS_SERVER 2.12.1-RC.5

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='3730c43a85bd5a55377b6aaf76190a7f0adeb97b4893142aa5671827603c8c7c' ;; \
    armhf) natsArch='arm6'; sha256='d1c5a3f0e8e6740e9985b117d895c7c549ae76e4ec9c48d8d875296600e76e5e' ;; \
    armv7) natsArch='arm7'; sha256='0d7b3f8a5d6511c7584cb7a29b278f1e364f39750848ff89b0814b5f0e76efde' ;; \
    x86_64) natsArch='amd64'; sha256='9d358f0f85fc6713c2211db0f26284602eb6732ff26edef9fcfbb7c6964c7816' ;; \
    x86) natsArch='386'; sha256='b7b422abf912feee50dd4fbc1f1b7df9192f589f779ecd19ee5f18a6195bc561' ;; \
    s390x) natsArch='s390x'; sha256='470a3fa258643707a86f94f07512d508ef5416e3fabf4383f3b81402687a06e6' ;; \
    ppc64le) natsArch='ppc64le'; sha256='fa91b1cd8e2c6d5663b74001f6296d1a8c69f17960cba3f2a529aaaa558a1063' ;; \
    loong64) natsArch='loong64'; sha256='9771d1952ea04f54d17a4329f1c0f4e10561874dd79f76b85bf4c0a24ee0b955' ;; \
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
