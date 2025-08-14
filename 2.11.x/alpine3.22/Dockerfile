FROM alpine:3.22

ENV NATS_SERVER 2.11.8

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='b08936cb1dc0ae7086137bda14c352df64397c4af45ed2b392705c19585aeb84' ;; \
    armhf) natsArch='arm6'; sha256='77508bd9f79b01a2b431393e4ba72004f57a07457793faeb366358512d3a1b91' ;; \
    armv7) natsArch='arm7'; sha256='271c4de30cdb5449f37709c5e64ec02f436aa489d309c5a5f64b46fa32d2000b' ;; \
    x86_64) natsArch='amd64'; sha256='397a6deffb5533e160de0cca322bc3dcaec7fb7282d66a3dfa87a9c183152ad1' ;; \
    x86) natsArch='386'; sha256='b12893ba9aa5a546c23cfd0c87f0afa44482d51ed850b8e171d6e543c126336e' ;; \
    s390x) natsArch='s390x'; sha256='6bf3289351dfb8805033802fbc9fc75a8a1329eccbca6e4074f7b8c2dcc5f8fb' ;; \
    ppc64le) natsArch='ppc64le'; sha256='d6ca70a7779057ec386bc29fce8a8f2c280ace83a20398af4592c25379539ee2' ;; \
    loong64) natsArch='loong64'; sha256='d4e3dc74fbc14afea6ca474a93a01e7a7028fab14fb622d4ac12c760f88bfbc9' ;; \
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
