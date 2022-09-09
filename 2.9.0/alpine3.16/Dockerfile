FROM alpine:3.16

ENV NATS_SERVER 2.9.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='b82c2910819bbf9350a5040ba2145b5e17d0faf8fca502505a4845ce1dcba441' ;; \
		armhf) natsArch='arm6'; sha256='4f5f02bd8e06e83d685f7cba76620ae76cdfb7bd94f89e3aea323bbd0bf6ab3b' ;; \
		armv7) natsArch='arm7'; sha256='0af9e816fb4a47274d2f7b1d1ebebd13568f0b70d466feefdd04cf1f14a0195f' ;; \
		x86_64) natsArch='amd64'; sha256='e2c678de6900dfd126ce181a1103201ac6fb4e63f7112d320932a011db64d4e0' ;; \
		x86) natsArch='386'; sha256='a617f94da82e2518549d2192d336be1da09674498553d117a95e167c4f3425ca' ;; \
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
