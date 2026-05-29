FROM alpine:3.22

ENV NATS_SERVER 2.12.10-RC.1

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
    aarch64) natsArch='arm64'; sha256='bd4cd47cc001690e3644f5b4b9f9d748bc149074d33cea4b55078b2e78c02ec1' ;; \
    armhf) natsArch='arm6'; sha256='dccbaf4bee0d209677218b286f08dc15c8d775d669d5666fb9d5535e7de01990' ;; \
    armv7) natsArch='arm7'; sha256='0c43647d839122ece715d90bb9fbbc612562a3ddb044135f23f85681fff06217' ;; \
    x86_64) natsArch='amd64'; sha256='713cb6ca2893e3327e7cccd6537e1c4cbd505eddbb775135051a43af8bca124a' ;; \
    x86) natsArch='386'; sha256='abeb53023fb519312a16d58a553c9ce559bf9e0bb78af747e8d1630441a2ac27' ;; \
    s390x) natsArch='s390x'; sha256='25c1e5f9d7f27d6d171de247c3ba03253807a8e095dbf109944c62fc91601d85' ;; \
    ppc64le) natsArch='ppc64le'; sha256='82049ef8e64f4becc2bf9e27a2412f06f71201729fa769ea4433a1c1294d8449' ;; \
    loong64) natsArch='loong64'; sha256='8f90268f28b3a3cb6ac1e820bdae9fcef0b3c235204dd9ad11af9ee67e9b4d0f' ;; \
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
