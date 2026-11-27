FROM alpine:3.22

ENV NATS_SERVER 2.15.4-RC.1

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
    aarch64) natsArch='arm64'; sha256='319883b2e7fdbb9cfd65590ed847ef1fa4c6829cb156e0eae9b129c2fb41a5b7' ;; \
    armhf) natsArch='arm6'; sha256='ed397dc7c532512d3371172ad8f22a7b9e85117e3653d8a150a997b22dbffc1b' ;; \
    armv7) natsArch='arm7'; sha256='1031cfe1dac0f0fb723720a67063259bc8a25895983a502fac3b5acb97ce007f' ;; \
    x86_64) natsArch='amd64'; sha256='249ea5a6203c86cbe61d3fde255ab9fbc5ade05b5527cb9b12fad9f6418bfb45' ;; \
    x86) natsArch='386'; sha256='970a5cd6672f61317f11df648f28cbee60ec1c5da535d7c46757b313e31cb1a6' ;; \
    s390x) natsArch='s390x'; sha256='7ffce1fd5491942ddd6f6e4927637b964075ff871b75a4cbcfea211ed02fb84c' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b863a7dabeccc7cc3058ce1a43897eccf7f916188b8dc678d26834e8ea16b667' ;; \
    loong64) natsArch='loong64'; sha256='9961948c76eb0838e598ede2ec522371d82f39430f23dd55c4ec68c7bd9404c6' ;; \
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
