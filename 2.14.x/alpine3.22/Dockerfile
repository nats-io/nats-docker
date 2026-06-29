FROM alpine:3.22

ENV NATS_SERVER 2.14.3

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
    aarch64) natsArch='arm64'; sha256='1759b6a0ddebade9471b7c02891dfaa8c73b526c6f3ce391d4e21ec3eceffab8' ;; \
    armhf) natsArch='arm6'; sha256='95d285b170a1417121fbb62ec5c9b618552855d072f48be86cd4d11544227704' ;; \
    armv7) natsArch='arm7'; sha256='d70d6de7ad0d587ad3047f4516a054f64b693edb79894d7ec0a2d176be31f6cf' ;; \
    x86_64) natsArch='amd64'; sha256='f3d0c820c749f81d717310fb00d4903919e70e3e66b268bd352a088b9788eb93' ;; \
    x86) natsArch='386'; sha256='071d031273136987af2da68103bd1080fbdd463b244c703388d0164726b17357' ;; \
    s390x) natsArch='s390x'; sha256='be525fec7cf3dac23e9617ca2b4b3767e79b1f684a456f3a2e85e1b3d40a6da9' ;; \
    ppc64le) natsArch='ppc64le'; sha256='12b4ecc73e7023b501a374913c7e70f7487107743dbab7cc7da627348b87f9d3' ;; \
    loong64) natsArch='loong64'; sha256='9a69c1fd01d290695cef2e33412e0e3ad4fe8e4af03faf0be137cd7e287bd55b' ;; \
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
