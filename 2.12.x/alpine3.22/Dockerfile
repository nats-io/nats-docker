FROM alpine:3.22

ENV NATS_SERVER 2.12.0-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='886062c91fe7ee64f1162a944cbeff9a0dc1b7169fb83a837897ef858a2e2a02' ;; \
    armhf) natsArch='arm6'; sha256='fd1895e7dcedecee7157cbc794b19b3e04f15db743cd9f9c5df98316474247cc' ;; \
    armv7) natsArch='arm7'; sha256='541019336d8821ac8069c246b63aea102662b938c0c1d6ef01b5a336c289fc71' ;; \
    x86_64) natsArch='amd64'; sha256='81d10b727318824a805702e930834fa25e789fddee0a1d60af0939f900b96641' ;; \
    x86) natsArch='386'; sha256='a062c9d51da6bc99fd2bbe9f5aae7d83c20753a38b13afa7498b9888f2ee75fa' ;; \
    s390x) natsArch='s390x'; sha256='9b251bb143ca02f723610dcf4891319e911ea7559d0ef68d3ed1c44543b30ab1' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d18f5881785df8fd61bbe9cde25a6f8c0d29dc5efb02935c19e7df8de10f521b' ;; \
    loong64) natsArch='loong64'; sha256='00ff0d1cdd7006b18779e48b471a1c256e3abb7a86362ff63a43c15e0819a446' ;; \
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
