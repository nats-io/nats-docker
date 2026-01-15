FROM alpine:3.22

ENV NATS_SERVER 2.11.12-RC.3

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
    aarch64) natsArch='arm64'; sha256='51ab9025c0080bc184fb014f16434e49bd912a87bc8a39aba0206242986cb6dc' ;; \
    armhf) natsArch='arm6'; sha256='b18eeec12055eb38213e510f555d345e36acb4a842a81373cd3729528a7bf548' ;; \
    armv7) natsArch='arm7'; sha256='77b5068dd2995ffad43190a369d528070a407dbbeff33a801f210c517da57c15' ;; \
    x86_64) natsArch='amd64'; sha256='c37c30b344d9101afcb414b5d04edb760632b86d747d51d02df8bc94e5fa87b0' ;; \
    x86) natsArch='386'; sha256='089775119a38f0e4011e05c30215a191791fb9ad7528fbff926a226adebb65fa' ;; \
    s390x) natsArch='s390x'; sha256='c8c72c2f4a2e9c1f96da86f1fbd102988bb88b451ef6726879baf48632eb773f' ;; \
    ppc64le) natsArch='ppc64le'; sha256='9dddb682790acd00d99b5bf0f99580c3f5d474d37298549404f46b30da115364' ;; \
    loong64) natsArch='loong64'; sha256='11c41c2fd733e117d9be35561020a6395545494da37703cf45933f4ed5f139aa' ;; \
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
