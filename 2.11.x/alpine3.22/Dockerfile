FROM alpine:3.22

ENV NATS_SERVER 2.11.7-RC.1

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='5901f524ebfed3efa80dd53656a79cfb633c041e3d6fc0ccba284044de018611' ;; \
    armhf) natsArch='arm6'; sha256='cd22056d30a4313a57e97f2ed4b80a2868b04bd072c52bda321e575bcbde1532' ;; \
    armv7) natsArch='arm7'; sha256='fba6244f5e193415de7e36336bc2280d775d019083223a681e4f1dd2910a8a40' ;; \
    x86_64) natsArch='amd64'; sha256='07de080ad817a582f0ef74e280b229eeac44817ec629801098e35936a59320ae' ;; \
    x86) natsArch='386'; sha256='a2e5c2fd512604b7d0300662bce5f2c766655894eb2bd8614833d34c5d01fc72' ;; \
    s390x) natsArch='s390x'; sha256='7c8107228e3abb863ebc5fac169d3e36a70db8b423bab43611c89f6bc9dde747' ;; \
    ppc64le) natsArch='ppc64le'; sha256='c9e2f54d98749e874ea0bbda9e11c6d4b0efa035117bd885368d3053b635ea9f' ;; \
    loong64) natsArch='loong64'; sha256='507206c826ae31572ec34d378fe6d2e3fe064a541738b8acfafdbe2ddfdffaf1' ;; \
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
