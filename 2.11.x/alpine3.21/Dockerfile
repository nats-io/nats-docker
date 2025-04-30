FROM alpine:3.21

ENV NATS_SERVER 2.11.3-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='24e8843dd582891e85e7face26285e6e4c8bc9146da104a1098860ce45ddfda6' ;; \
		armhf) natsArch='arm6'; sha256='176751dc2053e6ecef760152c027565632ef19e7f5cd8c1762d88bead4a24b06' ;; \
		armv7) natsArch='arm7'; sha256='b028c8268817c8ef36227bfcbee207cdc9b6b008b3fab7f8515c8635bd75dbcb' ;; \
		x86_64) natsArch='amd64'; sha256='8efc5d4346fbb02415d7a8e7cdec13c0658c1952fa1aa23f760021a19ef3479a' ;; \
		x86) natsArch='386'; sha256='56495f1e35251c16cd4ef1e73a063eeacf647401cafb48eddca0599ecee112ac' ;; \
		s390x) natsArch='s390x'; sha256='ae3f176b4bc54d38ff731851537011539daf120eac61be7876aad62173c3462d' ;; \
		ppc64le) natsArch='ppc64le'; sha256='8b2f129ccba21f1d49c6be7b71e000483fcf5ed5bf5028684a568454a0f6d37d' ;; \
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
