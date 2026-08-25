FROM alpine:3.22

ENV NATS_SERVER 2.14.6-RC.1

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
    aarch64) natsArch='arm64'; sha256='29985eaa52f4537b3a67970911f50b5dbb6a7e549884ab3489c18982636a29fd' ;; \
    armhf) natsArch='arm6'; sha256='74bf3a45677861c941671bdd59399f8ec0dbad8a4e21e54621763f6be8a1eaea' ;; \
    armv7) natsArch='arm7'; sha256='c752200b55cdedd35b526b3236224f129a5147eeb6db40c4058209cef8ea4827' ;; \
    x86_64) natsArch='amd64'; sha256='3491b8dfa3a72117b25750f0a01f1c085f393b31ceaca1e707eb9a9a0e17b358' ;; \
    x86) natsArch='386'; sha256='79a9d887765f852f66589a2335a4162084283afb2d075b7068adb73f157f6868' ;; \
    s390x) natsArch='s390x'; sha256='7aea9c97ede433ec3964670425572681a646fd2573c5a45948cfc3b84ee5e986' ;; \
    ppc64le) natsArch='ppc64le'; sha256='32921b36df34dc0287e4a29929ffca142e3df491f09d53469fbad300d6f715e0' ;; \
    loong64) natsArch='loong64'; sha256='4dc3b688a9db974772a6b73efd2e4442be5fdd928ca741334788ccade33d1189' ;; \
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
