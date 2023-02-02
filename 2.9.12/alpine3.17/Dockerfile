FROM alpine:3.17

ENV NATS_SERVER 2.9.12

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='296075e7caa33684f0a23ac97c2a904c8f22dbc1d75da4ab443a81aa8b1b765b' ;; \
		armhf) natsArch='arm6'; sha256='72af57a620de31e718131736b4ae123acd994295b2f81d1f847cdb9e1e686e63' ;; \
		armv7) natsArch='arm7'; sha256='153d823e90b76457b6689cb6baa9f045b3a2152caaec787a0ad77162431949ed' ;; \
		x86_64) natsArch='amd64'; sha256='cd05e53b3e1a535dd4e09a4cba3c1b0cd7c512e7f3d68d52ed8e8621dac8c925' ;; \
		x86) natsArch='386'; sha256='103d89a231154708375a091dfb86ebe563f3de968a5e6ed14aba4c32e5c77925' ;; \
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
