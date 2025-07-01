FROM alpine:3.22

ENV NATS_SERVER 2.11.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4fe3c40bddc58e31012f55865df0dcd24012995d2893a4d64a0ae5cb147d7a36' ;; \
		armhf) natsArch='arm6'; sha256='247ed4cd1682d5a77d93add9ebc806a9bfcac39981a9f0048678006895d3146d' ;; \
		armv7) natsArch='arm7'; sha256='85044d4a4c13f910820c6727b8e748b97a6c73a6b4cb206cd77db9cab62be074' ;; \
		x86_64) natsArch='amd64'; sha256='5e5272dd1bdb8da020aedc8cf883fb26c128441809a992f156e0b1ccb28ac5b7' ;; \
		x86) natsArch='386'; sha256='0d601a8bd963f32597d3534a884e3a90f43400f730b666e407a0b59d16f09db9' ;; \
		s390x) natsArch='s390x'; sha256='80f6cdc098aaffec4133204a0e83f9866ed379fcc274c07b129201e0e7e47e3f' ;; \
		ppc64le) natsArch='ppc64le'; sha256='97ff93f6a3ef10d1bccb583d204848d93d30624dc328de8579f77e9c6c96f8f3' ;; \
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
