FROM alpine:3.22

ENV NATS_SERVER 2.11.12-RC.5

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
    aarch64) natsArch='arm64'; sha256='a4c96255a069579b75e2c897003d626f0766d80aac93bc118c448e707709d63e' ;; \
    armhf) natsArch='arm6'; sha256='cd096aa7bb2b18b2e463ec4e82f18ab35b3df57a5b7f01a215c55799320416e5' ;; \
    armv7) natsArch='arm7'; sha256='dd6a621429fd437da4006167dc272b1e30b68bca7a7d42869ef11a3374ca497a' ;; \
    x86_64) natsArch='amd64'; sha256='0c2491b089d260be80738298ac278437e39a00792b232cc0758b1c42fb23b1a6' ;; \
    x86) natsArch='386'; sha256='bcfa1eb9eb21cb1c17ab86340e52a3436bd01e758715ee94a8d1f537a3bcc383' ;; \
    s390x) natsArch='s390x'; sha256='a1cbc959cc733885b7aecfb18e0520e87579512f6ad7c0b1b3a9791a5d17100d' ;; \
    ppc64le) natsArch='ppc64le'; sha256='3b1f972c160478f33c469ea5d5e311da1ce138b3e192c4723d40c14d6ef173ba' ;; \
    loong64) natsArch='loong64'; sha256='99bdc4d32ec105aede338946aaa2c815003ae8fa255e042ebceb286d59bbc0e4' ;; \
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
