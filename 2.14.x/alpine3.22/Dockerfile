FROM alpine:3.22

ENV NATS_SERVER 2.14.0-RC.3

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
    aarch64) natsArch='arm64'; sha256='6edfd8ff4aa538979d2b8c5e53d98046a76423fc23b51723da7d62c652a6a4e4' ;; \
    armhf) natsArch='arm6'; sha256='1926f0944b5462b5caf80a2f596a6174eacfafe3da72dae953845de31d738aa9' ;; \
    armv7) natsArch='arm7'; sha256='9418cf0857ca961b3ad8d5768289ff71119178b641e21e9eaa6eabe7373f7f6e' ;; \
    x86_64) natsArch='amd64'; sha256='78d2c41bc25724a5055ee693dde1f3aaa98ff96284d9d9e256f8227e58d8852f' ;; \
    x86) natsArch='386'; sha256='e08bfc4a3ce61e848c38b846ec6ab83e4bb4f83634afcae33faef34e31021619' ;; \
    s390x) natsArch='s390x'; sha256='4f46391f90c2a75e8e9e339083e982ca0604a02ef74646bc0580013e1f797554' ;; \
    ppc64le) natsArch='ppc64le'; sha256='dd98db65f80d225cb205395b6411d85cf619b5c5503053ccf1c7912df2a62868' ;; \
    loong64) natsArch='loong64'; sha256='d2ccee99bba861e1dcd786a15d7ca4cc663fd6b5d5d4d2d4de7d9cbf7557a3b0' ;; \
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
