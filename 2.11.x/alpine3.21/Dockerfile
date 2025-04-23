FROM alpine:3.21

ENV NATS_SERVER 2.11.2-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4088a5bc78c50788b6da96e83dd2a9ac2100708a3991ed48ba6ba5234ecc5e4c' ;; \
		armhf) natsArch='arm6'; sha256='f1d6a7670733fad68b9928028fa52e878336c9eca33fbc1d7ceb20c6c55b63e3' ;; \
		armv7) natsArch='arm7'; sha256='0e6499c302a0733aec48e65bbfb7a498878fb533e6e6fb92c8eeb601fb7622d5' ;; \
		x86_64) natsArch='amd64'; sha256='b0142b97c82f7e60df6f09f41b22baa677f6bf2cd5669328619a7fe8e9a623c1' ;; \
		x86) natsArch='386'; sha256='332dc0f64fc5dda1e461339b038a9821509c1b78714d3b767122121117b2eb70' ;; \
		s390x) natsArch='s390x'; sha256='8683a32d85286cc576757485a237288c2fd70d345ee22ee39b08ef55446e36a1' ;; \
		ppc64le) natsArch='ppc64le'; sha256='3a3b6eb6b81af66765c32309fe70104b51b3421889453929b3da843b3e22b8c4' ;; \
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
