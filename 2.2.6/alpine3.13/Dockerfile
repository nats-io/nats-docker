FROM alpine:3.13

ENV NATS_SERVER 2.2.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c3888de97cd9b3fe3a968827b765c87f47d0a9d446c795895189506d5d50ef45' ;; \
		armhf) natsArch='arm6'; sha256='d5fd9b119aa926d1a819f1ef4f09b393cb8f5c33d0a63829042911ef1b9e3def' ;; \
		armv7) natsArch='arm7'; sha256='b736bfac73a74e650b67281a9fad6cd83cd1aa58824a5582a923058c5dfbca08' ;; \
		x86_64) natsArch='amd64'; sha256='2808f83e2f00ac785d5862d04080d9a1390c60cfe6bde83fb3cad9f9a077aa53' ;; \
		x86) natsArch='386'; sha256='ca539737be6ef8ced63b5f62254f10af228925f80bd59788c4bfb388439e49d1' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
