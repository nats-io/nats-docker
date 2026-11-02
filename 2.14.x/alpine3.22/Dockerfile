FROM alpine:3.22

ENV NATS_SERVER 2.14.10-RC.1

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
    aarch64) natsArch='arm64'; sha256='76cb9d6f5127ec646fd1d4e4ef71c4fe7c5e220c7be75118ba510e9218e752d1' ;; \
    armhf) natsArch='arm6'; sha256='7944157dc3f9dd7610df11ed690c849249794706a4797a06e1bbe17837d6367e' ;; \
    armv7) natsArch='arm7'; sha256='6ef80c74675fd7cb74432cbcbab2554a6177067629aea3fd2de67b3111e5808d' ;; \
    x86_64) natsArch='amd64'; sha256='70b432894238b5395b8ee8b6802fc87708a0db46dc5452f98ddfdee67ee1efa6' ;; \
    x86) natsArch='386'; sha256='c466ca9dba5907333d6157761332ef408940e2abaf3f79423dbe3c87afa6252a' ;; \
    s390x) natsArch='s390x'; sha256='4823eb68b2aeec92a8e4e86df0da3ade2541bbc08cdd1f1bec72b5dc01f051bb' ;; \
    ppc64le) natsArch='ppc64le'; sha256='b0067363a1bbccd7512f8866da6b5bafcc7cec66f66c8aae3741a09e53006aa8' ;; \
    loong64) natsArch='loong64'; sha256='eda99cec280275bb07e744a54fa72bf2c49ed379e90c23da2961b61bb22ff63f' ;; \
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
