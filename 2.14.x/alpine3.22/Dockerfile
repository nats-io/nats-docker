FROM alpine:3.22

ENV NATS_SERVER 2.14.9

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
    aarch64) natsArch='arm64'; sha256='e4f437b27c5966f65efdc5c17e5e50a02daea424cd2efc71df2ca514119ee4bc' ;; \
    armhf) natsArch='arm6'; sha256='f909e0b31875780c8c82841372231bbd8fd064c6085b0dfefec7b31883e9707c' ;; \
    armv7) natsArch='arm7'; sha256='459a2b21599a02cab61799adb0b950c530bbf81e05a253a42a7f3fa4a0c70ec9' ;; \
    x86_64) natsArch='amd64'; sha256='74f20433c5b39d7cc6db54155ec1e669671c728f625e54cf307298924b2b4259' ;; \
    x86) natsArch='386'; sha256='a8777c8673b585760c1e9b431210efe5d45cb21b00eeed93048c54a82cb340ee' ;; \
    s390x) natsArch='s390x'; sha256='ecfdee73d022cd20361f58fa20913dbb5f743fb42c52cdb60248685917c247f3' ;; \
    ppc64le) natsArch='ppc64le'; sha256='ba6996ff2b87bf80ea4b2931070cfc2700526170466b8c1ee6446dc377a3e525' ;; \
    loong64) natsArch='loong64'; sha256='e5522ede01ea910392aa99b549daa43aecb581c4a7dd809cee03b771228d2ecf' ;; \
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
