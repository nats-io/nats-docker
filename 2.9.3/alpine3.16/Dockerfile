FROM alpine:3.16

ENV NATS_SERVER 2.9.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='8d156c27e2702f4e43fcad0ad28f7e6ccf490777b8f78c25aba45125d541dd5b' ;; \
		armhf) natsArch='arm6'; sha256='74204a66f8c76637d0e70d91f9ff22e35e4a55d6204d71820ba22a945a782b73' ;; \
		armv7) natsArch='arm7'; sha256='280c4de193b2759f8a9c4bd2633b481fdbbfc5b45bda87d7926731e6bfc1ec31' ;; \
		x86_64) natsArch='amd64'; sha256='398aa61a5dd74d1bc14a30573a1eb9114e3a92621c350f93baaf453696ec3526' ;; \
		x86) natsArch='386'; sha256='297c21a9024f408a63c7b5b7e040e2256eff4f5fd34c7297727a82e223786812' ;; \
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
