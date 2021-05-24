FROM alpine:3.13

ENV NATS_SERVER 2.2.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='779d7f363fb0244071e67bf146c7169a8e3c35af2746c0a01323a3c5fd12bf31' ;; \
		armhf) natsArch='arm6'; sha256='ed7211f56fa3928e3664ed92df632b0e7480bd1b4a91c239cb26a0f55831c815' ;; \
		armv7) natsArch='arm7'; sha256='a55335b1329248912e80d8e68b5dd6b6a48c4742de089c4226f503d7e8357f2c' ;; \
		x86_64) natsArch='amd64'; sha256='fc67ce0b4c748fa16ff92414c7d6be18a9285824c21d9629684c0093cf074f77' ;; \
		x86) natsArch='386'; sha256='386811034531cea6e794e4764fdd70b0b948fdf7212064e8c176663992c46f2e' ;; \
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
