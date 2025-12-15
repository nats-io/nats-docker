FROM alpine:3.22

ENV NATS_SERVER 2.12.3-RC.4

LABEL org.opencontainers.image.title="NATS Server" \
      org.opencontainers.image.description="NATS is an open-source, high-performance, cloud native messaging system." \
      org.opencontainers.image.url="https://nats.io" \
      org.opencontainers.image.documentation="https://docs.nats.io" \
      org.opencontainers.image.source="https://github.com/nats-io/nats-docker" \
      org.opencontainers.image.vendor="NATS.io" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.version="${NATS_SERVER}"

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='20335c4f6c1200cc89ef43aa1cdaf680ae7b91b9941843a9ccfebe153a6f9959' ;; \
    armhf) natsArch='arm6'; sha256='4a7ef703a25c70ec6f523ece4ad25aace00f2afb6a87eff1efef96bc32cf4815' ;; \
    armv7) natsArch='arm7'; sha256='978fdd997fc44bdaafeecaf933fc49425118e9f7e544673f2b7647957ab93749' ;; \
    x86_64) natsArch='amd64'; sha256='41289e1895c5e08f7830e16ac89a24dc36f6a2fb18af9b00a80c96399044decf' ;; \
    x86) natsArch='386'; sha256='786c624f69dfb0494aff5c8874f8d39d345a92b660f180cc385c6aad2b9a4d94' ;; \
    s390x) natsArch='s390x'; sha256='2624d9d26f39bb666e0035ac9dce80d77a2565c6b1abb6cf672f0897f2adb5ac' ;; \
    ppc64le) natsArch='ppc64le'; sha256='99f9c581d819ff04ff1807ec522e2f0d8b8d533f058ebbff12311a5462466008' ;; \
    loong64) natsArch='loong64'; sha256='4964fbb6ea09bac06faba837b9fa66c92336be2b9b759a92b8d98bcd854b079b' ;; \
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
