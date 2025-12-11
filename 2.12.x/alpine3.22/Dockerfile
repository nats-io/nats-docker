FROM alpine:3.22

ENV NATS_SERVER 2.12.3-RC.3

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
    aarch64) natsArch='arm64'; sha256='c3971ee3f0730965319e47c186d14c04a9e39fceb08e31b03541832542d5f8c9' ;; \
    armhf) natsArch='arm6'; sha256='9ccfce3ba030e64ad1df7d8931f509d026a212a7ff56404164c9ac1798da36d5' ;; \
    armv7) natsArch='arm7'; sha256='6dab0be50f0d5ceadfd88b704f27cee4d0d26b07eaf07402e558029a810dbebd' ;; \
    x86_64) natsArch='amd64'; sha256='6980b631de7308b418a972bdb122bfc22e373b581f18c1453827f159a2604ea6' ;; \
    x86) natsArch='386'; sha256='f8395ea3508dc8046c7d470cdf71bbbe52b7effce8e4e069612d07b132a61998' ;; \
    s390x) natsArch='s390x'; sha256='50a2f90d242eb28e5b9044ffd99cfcf1a792838e58f5ded1b27df001b0f096dd' ;; \
    ppc64le) natsArch='ppc64le'; sha256='0908e38362307818d37fb81463ede9132922a05409588436e5643da703d6ce74' ;; \
    loong64) natsArch='loong64'; sha256='17322e558cf2b89f8d429b349d266e8edfa3471471b5576e15c55241e2d175a3' ;; \
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
