FROM alpine:3.17

ENV NATS_SERVER 2.9.9

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6c0bfc475521c54df3602171a8229d07ff24520f2e7ea7788788e20d01b3b657' ;; \
		armhf) natsArch='arm6'; sha256='cc41956b152d942c892cfbcee1f0ab9c632b4729b9bb53962c89e11701ac4458' ;; \
		armv7) natsArch='arm7'; sha256='c246ea76e20d0265de10c8af81b4b19c9659401b5ec68db0b04422bd92d273ab' ;; \
		x86_64) natsArch='amd64'; sha256='e1e0e4bf2bc731aa63508c6794cc454a085aedb120752e51ecfe3951bfae9fde' ;; \
		x86) natsArch='386'; sha256='961c820aad39a095e324704e9305b9311c66599f3cabee0e6d4aba701fae8521' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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
