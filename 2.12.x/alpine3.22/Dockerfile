FROM alpine:3.22

ENV NATS_SERVER 2.12.4-RC.2

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
    aarch64) natsArch='arm64'; sha256='6dd1bd7c6e33a185fa174f51ab600009690c6a89a952653f769627e9b8e7846a' ;; \
    armhf) natsArch='arm6'; sha256='72033cd8e29e213a97c70c6e02eb3e1704d1c8dda94e5ca25dfe3c45a78d5ae1' ;; \
    armv7) natsArch='arm7'; sha256='43b42a8098d8b3e4ebae2791a83b91b54f3af7058e97fd687a5ef19aad165987' ;; \
    x86_64) natsArch='amd64'; sha256='36ba00c5a927cd3da5cffa0d99ee8fdc43ff5cf508257ef4fc03043dfd305033' ;; \
    x86) natsArch='386'; sha256='f0e7290ae0c76022615e690ece1639d45fbc9f0aec7ed921fd52fae1c6358e0d' ;; \
    s390x) natsArch='s390x'; sha256='8bf56448ec5b932d5b7417754331d6825ca716985ef2c0aa53e1618b8cd54935' ;; \
    ppc64le) natsArch='ppc64le'; sha256='0e7e1ddcf8fbe5fca532400839027b09ac2216537c7e453c49f695560bb1ac16' ;; \
    loong64) natsArch='loong64'; sha256='7d2188ac219b69cea9b4024edad9b1860214a1493406d6225a57ec6457a20c2a' ;; \
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
