FROM alpine:3.18

ENV NATS_SERVER 2.9.20

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='59ebc51e99fd97f92b8ecf3d0ee566aef9e133c2fc0a981e0522c105490c2e99' ;; \
		armhf) natsArch='arm6'; sha256='c27abedca49baf59799630505f9e37ae22dc9ec644f0a645537e1b5d33221491' ;; \
		armv7) natsArch='arm7'; sha256='fdd51a5c3ed7d47ef5efae1e9861e317df37e385205e45df63c35968650e59e4' ;; \
		x86_64) natsArch='amd64'; sha256='626288430030b63a05b1fa79aa6ed84344c29ae78808e62b078add906d77f138' ;; \
		x86) natsArch='386'; sha256='7db99a9d9e2b87304dab0745409b51dbb1a366705b0d08bc7da5ad025e30140e' ;; \
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
