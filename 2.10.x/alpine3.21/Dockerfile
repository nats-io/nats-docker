FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f39fd110eb14b21e681f8cfd75579c6243d45a683eced82ad1e9fa0a45778f31' ;; \
		armhf) natsArch='arm6'; sha256='db4a359bce9ffa2201efe91a248f12e04b33077b94714e38568d916b1f4a678b' ;; \
		armv7) natsArch='arm7'; sha256='1f79d678639e2feeea0a2f864ed91104a5cfa8f2a6c823bffc3ceb95bf34925c' ;; \
		x86_64) natsArch='amd64'; sha256='cbabbcf7d273372200973832829472babe23ee0b82556a41194fec701826ed20' ;; \
		x86) natsArch='386'; sha256='74dc4355129e4d732b0ca63396b1ec7723913c8d1f0724b901d71009d4abe62b' ;; \
		s390x) natsArch='s390x'; sha256='dca45974fd77c8be42d0ee0f2976b431429c8a64996496f76b20bd72405c74a5' ;; \
		ppc64le) natsArch='ppc64le'; sha256='7d0c21a2f8776720ecb633d33f674e94b9d3fb48f00c48a9b322c1b128aa6629' ;; \
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
