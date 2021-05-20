FROM alpine:3.13

ENV NATS_SERVER 2.2.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='12f06d3ac1af3872c8b77722e19faa508b979806641a6dc2707f641de270aa49' ;; \
		armhf) natsArch='arm6'; sha256='a61769ab4f4176c882a69209bbff54e0e7e8bd6e986ba8841d5a061a4f8cc72f' ;; \
		armv7) natsArch='arm7'; sha256='307b3a42492a0a0172df5d00dea3355064daf5cf38653a1835fab39ca0393415' ;; \
		x86_64) natsArch='amd64'; sha256='e4f57f263c7411f6028e9cd6080c6fd35090de4168c21c3e8b7a5ee5a632d142' ;; \
		x86) natsArch='386'; sha256='fd3025f88aca3e89d1015d5d3aedfd9390146b168703e2777616261bcc752e2c' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.zip "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.zip"; \
	echo "${sha256} *nats-server.zip" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp unzip; \
	\
	unzip nats-server.zip "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server"; \
	rm nats-server.zip; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rmdir "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
