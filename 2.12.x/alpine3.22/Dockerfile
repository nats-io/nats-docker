FROM alpine:3.22

ENV NATS_SERVER 2.12.3-RC.2

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
    aarch64) natsArch='arm64'; sha256='bc5c99fb46db6b225584e8a4e337bb3451ab2f113d3f714fa25924eb5c7426da' ;; \
    armhf) natsArch='arm6'; sha256='e49359a27bd9b68db56b1a519a6e845010096246357cf2477a1f027acb922662' ;; \
    armv7) natsArch='arm7'; sha256='6bf3849c16e5a15ab4b3eca35c06544f1e70caae0fad55b569e1ac442e187ae8' ;; \
    x86_64) natsArch='amd64'; sha256='02128998dc33df6d1a406ad04c9bc96f065346af119fc0412587986ecc068c94' ;; \
    x86) natsArch='386'; sha256='5532d2fe4ef48f0bec197c3e2aea84694dadecd4de5ded75ffc0ea290de8a803' ;; \
    s390x) natsArch='s390x'; sha256='350679c8190151f6f2f01e412f8c10f24397d88af17de6660fd57590312b6599' ;; \
    ppc64le) natsArch='ppc64le'; sha256='5a36526877b639fadec71f68d86d8e5eb5bcf107c91554c47d7c3c5a76224340' ;; \
    loong64) natsArch='loong64'; sha256='fb77932531b00564282488969384331adb2334b6774195ab2135125cbd4d52a3' ;; \
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
