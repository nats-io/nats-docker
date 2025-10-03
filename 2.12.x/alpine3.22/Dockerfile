FROM alpine:3.22

ENV NATS_SERVER 2.12.1-RC.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
    aarch64) natsArch='arm64'; sha256='4004cdf87477f2da6158e1f42b0f43d40e3d291bfb729a767b99fe6b70e05205' ;; \
    armhf) natsArch='arm6'; sha256='7be53e265422a557be39717e80046672805d298ca73cc7f453483835e5ce0861' ;; \
    armv7) natsArch='arm7'; sha256='c3705501647af1f8dced254e69061e8707740b9d1f757dae1421dc766e12b8c0' ;; \
    x86_64) natsArch='amd64'; sha256='0c330d0464622c1bd691e831ad3c0a3f74944b25ef37947f01fc83e13ffc48ac' ;; \
    x86) natsArch='386'; sha256='1b2407ea3174acc6230a26df2bdc8e2c34a477eddeeab06307ab19bdf459655a' ;; \
    s390x) natsArch='s390x'; sha256='8824ece6cbcd985bffc5fdb9908dd52835cc2f9b12b0f90c0caf6dbd15174799' ;; \
    ppc64le) natsArch='ppc64le'; sha256='90d90cbb3ae5d2bb59fed36bb618e2f78b961050ca0e21ded716519468ec8dfa' ;; \
    loong64) natsArch='loong64'; sha256='57b4384f4f0996e44055061be412ded999104cc56fbd6673314a6a024dcb7988' ;; \
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
