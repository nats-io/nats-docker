FROM alpine:3.22

ENV NATS_SERVER 2.12.4-RC.6

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
    aarch64) natsArch='arm64'; sha256='aa7da0a3b6a24c1a34f0349878ea9f77408584a2a3a8a014f1052776fdff565a' ;; \
    armhf) natsArch='arm6'; sha256='6eed87c749391b6149c7bc60d38653316bdaee2957a9b7ffc4d5d374cacd1b03' ;; \
    armv7) natsArch='arm7'; sha256='62e569f369b47f011fc0d20656f2a7027f84f7e026c49bad2e8e4d8ed06ba415' ;; \
    x86_64) natsArch='amd64'; sha256='9b6f764642c93fc7cf2c909e654f97525d4b4fcec85b8b1893086271e8c426c4' ;; \
    x86) natsArch='386'; sha256='c73f8365a801bd83620dc913273fcbe1117a102d527f8a492b6848d91006e8eb' ;; \
    s390x) natsArch='s390x'; sha256='17a73144e23fdb3797ca524ff04f114089b68888357230ddf030122f88c61e84' ;; \
    ppc64le) natsArch='ppc64le'; sha256='66ee1abbad3ffcfa98a702452e0aa98679a11ded9541980a0958f58efb0f4b2c' ;; \
    loong64) natsArch='loong64'; sha256='eb21d0c92a5684ece3c0064279908c4b01488208e0b1c19120df5a8d28c8845b' ;; \
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
