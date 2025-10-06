FROM alpine:3.22

ENV NATS_SERVER 2.12.1-RC.3

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='6d2f108acfd0eee9cb3d872c1bad7285b10b1857cdc8347f51e369a96fa68da7' ;; \
    armhf) natsArch='arm6'; sha256='25a94c39733bff303893c59aef5fa529d3d9d12c9fd15438bcfc17f86d1a5228' ;; \
    armv7) natsArch='arm7'; sha256='3b867891e32137fe83cd4bc41e8de46292d37abbffbb858b0ac4b49bfa668b96' ;; \
    x86_64) natsArch='amd64'; sha256='064cb790213253bfbf3cc8a7ac8694983d15cb01328f3920376c14d99eae34fe' ;; \
    x86) natsArch='386'; sha256='bda50c78628905d7cb119799775a0b5d6c42152ec7f4de396b42308568737c4b' ;; \
    s390x) natsArch='s390x'; sha256='db9db6bc2f4008ba08ec2d4d4ef938bd26ac878bf961422e8de731c78071e977' ;; \
    ppc64le) natsArch='ppc64le'; sha256='492ede36d215afa17bda1a5a57d813b7d08b06389f2837a9c65098332fc48f8e' ;; \
    loong64) natsArch='loong64'; sha256='da21361bd49f82f9595032609612abb5c0a76bc239e2f654f4c97dafb5511f2d' ;; \
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
