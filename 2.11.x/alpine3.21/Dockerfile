FROM alpine:3.21

ENV NATS_SERVER 2.11.0-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ec9c06c00ac58c5e3bfad4ad7446ef11495dfc49ab7b6c3fc770ce1060c96373' ;; \
		armhf) natsArch='arm6'; sha256='c1e6ffeb59bf5d1024aabd2c8f97492202c9c37341de4a71a75701a6af28fe77' ;; \
		armv7) natsArch='arm7'; sha256='4f8b83e171e9f126a52abf2ce2deb61e22ff0b88a1bd03eb0fde3dd4dc25a079' ;; \
		x86_64) natsArch='amd64'; sha256='d7118210e6ac754eded554b1773708d3d0c5eeb6499277037bdfda3fc1a4322b' ;; \
		x86) natsArch='386'; sha256='a3f9d9bee59f34ae2c529a5954670a33dda37f86e4952cdb7db12a01143a720b' ;; \
		s390x) natsArch='s390x'; sha256='4606491dbb0e2db5609ae7262cb9a0447b9d19239a82da1e7f1f0e9860890bd9' ;; \
		ppc64le) natsArch='ppc64le'; sha256='e334c4ff4f9da411d940b05fba7b206f75ada6d4f978cc073ddc9a8bc44c6723' ;; \
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
