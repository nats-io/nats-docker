FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='5c42bb1ff32815a8acbef14f310e37f6e41b611b535ac8f847b448ab2acff86e' ;; \
		armhf) natsArch='arm6'; sha256='da1be905aa7357562cae9fc50deb51c1d5ba1310eac44ef441ed0cc8094b87f6' ;; \
		armv7) natsArch='arm7'; sha256='97a8e883016547da5277470473d39a085ab4008d5e293f7d8aa9b576a6221fce' ;; \
		x86_64) natsArch='amd64'; sha256='d9864fc1328445f001c502fe7a0b6e2515e7c85b5809b89e20e05ad4ff9d8641' ;; \
		x86) natsArch='386'; sha256='054b9f49eec50025c32d197e150c9fdec0580e26cd0aeb20882e93e99d8ca3ca' ;; \
		s390x) natsArch='s390x'; sha256='3de83b8e630d3a2e7ad20b65b7dcdad170955d5e3491f687a065fe6efcce8b3b' ;; \
		ppc64le) natsArch='ppc64le'; sha256='ec56c24fa65fc97abc691037e960fa9173fa1cf4cc35d2aa3ab1585c51074359' ;; \
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
