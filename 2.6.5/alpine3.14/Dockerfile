FROM alpine:3.14

ENV NATS_SERVER 2.6.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='85b30b3511b4b66764d6b9fcf3c91937b778e8beb8dd44a179622b08869cfbbc' ;; \
		armhf) natsArch='arm6'; sha256='c2b3a7d5e443b8c4d75f4268e8a3e302d1174b3cdb2daa45497869edc993264b' ;; \
		armv7) natsArch='arm7'; sha256='66af4d04f5e963b93ccb259c6bd4e7532cc3126d1734781cbb5dbb14a01fdd8c' ;; \
		x86_64) natsArch='amd64'; sha256='5f5799014b82a02433f4f6333ad84d45da16696f1bf294ce8f2740ea05ced10b' ;; \
		x86) natsArch='386'; sha256='6bc66f8b5be8163d9ee1d3811e8907717538ccbe242b665962b38ead0a2e62fb' ;; \
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
