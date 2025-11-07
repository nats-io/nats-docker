FROM alpine:3.22

ENV NATS_SERVER 2.11.11-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='30cd78f18be83541dc0bae033fd00335947ce3e9fe896aaf178f376beb62518c' ;; \
    armhf) natsArch='arm6'; sha256='8374cda7bdd7cebd0ffea6fee2245fbe61d07a5ebadca059c16db21335a15263' ;; \
    armv7) natsArch='arm7'; sha256='d67d0f36df2b4925ea5ecea4621c09086fc7c931ffff061ce37c72689e54be3b' ;; \
    x86_64) natsArch='amd64'; sha256='39f1df8f6deaa0589ee42fea994c582a1f5829f377273f5912225f7c9f25ec73' ;; \
    x86) natsArch='386'; sha256='2da231745ce8ea2a3edc2794ac01965ada1434c3ba3764819b3e4e086f25377f' ;; \
    s390x) natsArch='s390x'; sha256='bd8bfdbf886161399105ecbb88a01bc594ed2c90369612107c9773c25454043b' ;; \
    ppc64le) natsArch='ppc64le'; sha256='25d6ef56efb81c8a6e1e7a0b387144a33365458bc99d8a73a78fd097c2feb71d' ;; \
    loong64) natsArch='loong64'; sha256='1345c5a5e419787da41eb65ac4f5ac0364eb0435f011ba311f49983e689ba896' ;; \
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
