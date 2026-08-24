FROM alpine:3.22

ENV NATS_SERVER 2.15.0-preview.1

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
    aarch64) natsArch='arm64'; sha256='d6ed9b37cba4def3484e7824c60c9a10d0ea44d1b091ab5e34007d2b600dbf75' ;; \
    armhf) natsArch='arm6'; sha256='f8576a53612b50712bd39197e62e52632f705a3684b7661b4a6f9815949d6a4c' ;; \
    armv7) natsArch='arm7'; sha256='b71d6e8c1e5ef7c4c804005a3779b2437524b5cba377d87d4c551c4acf0ab647' ;; \
    x86_64) natsArch='amd64'; sha256='a9eb8707b0ba0d10a2b27c20a384851acbaf849c62bb7102a5c018bdb2f53798' ;; \
    x86) natsArch='386'; sha256='c03c8533a9bdc20ca9089d0e5ea32f2fe810169a258f130ce03619a1f9b485ca' ;; \
    s390x) natsArch='s390x'; sha256='02d030813f9262840f05f2014c06b421d70db7c3f323357725d062db6fd0d7b7' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d6907043e0f0c6d1ce28eec8e4c05b8c924fbcd87af08577495471962655472b' ;; \
    loong64) natsArch='loong64'; sha256='6d93d1f79b8183758e3f7c5c505d9dedab434c9089a4e0cadfb50dfc962328c9' ;; \
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
