FROM alpine:3.17

ENV NATS_SERVER 2.9.16

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f73c99954263dc49374e755028c3702b03656b64e3a2bb247d95a3c27bd02d27' ;; \
		armhf) natsArch='arm6'; sha256='75726892cc2c852bf54bf3ff1761d6be6ff106e85e77452b7854e7dcc3c878bc' ;; \
		armv7) natsArch='arm7'; sha256='28b965758b25412ac0307c4dbc394b2f6783035bf070521f3cfef1441b655b98' ;; \
		x86_64) natsArch='amd64'; sha256='180b7f5f152733f9be1fcb0be607303a62c30b3e0d17bf2418fd548cd5c929df' ;; \
		x86) natsArch='386'; sha256='16344af0854c89e51f1b0ac1ebdea85d03d52e6f47dcfe0297a88861bcbf211f' ;; \
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
