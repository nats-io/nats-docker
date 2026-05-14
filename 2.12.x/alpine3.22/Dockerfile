FROM alpine:3.22

ENV NATS_SERVER 2.12.9-RC.1

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
    aarch64) natsArch='arm64'; sha256='1172615d086fc0b2ebb599fe9ef6211aaffaa77cd8c0c7c3fd644dc5df9d4a77' ;; \
    armhf) natsArch='arm6'; sha256='64b1b6db4ad8ee7070bd6cc7e445c1b020aee8430ce5330363ecbda44e280425' ;; \
    armv7) natsArch='arm7'; sha256='ef1de4e9e1953718cead68f27ed2d79c118578753c8d47a6cd2c8c81aa2b098b' ;; \
    x86_64) natsArch='amd64'; sha256='8ab4859b8207c39cc74563b53290ab308550e427fd613845c6d581145499123e' ;; \
    x86) natsArch='386'; sha256='538931564839a839498f952ed9e8729fcc95591dc23509348418dd4ea4b65491' ;; \
    s390x) natsArch='s390x'; sha256='f49f9cb403e9c47cc084878d10b6bacedf4f5ce671642d44c44886a14fd364fe' ;; \
    ppc64le) natsArch='ppc64le'; sha256='404a60be0a538cebc055bad6b092f2690cecdca5eb7369a67bc9eba31663787e' ;; \
    loong64) natsArch='loong64'; sha256='7dcfee3f32ab812afa82fc87cb24471a737e9e13939b1040162eff111ac289b7' ;; \
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
