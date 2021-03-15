FROM alpine:3.13

ENV NATS_SERVER 2.2.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4dfcf480a32d9ba7098477387d96a657a036ef9ad495a008a83e06b22df63999' ;; \
		armhf) natsArch='arm6'; sha256='b82fdb2c8f6e7c731254730043c145423b5c48a3b40e33ad6e32bce029a9f086' ;; \
		armv7) natsArch='arm7'; sha256='cffc326c7faeb5ea0769d0f04787d9885d5b2baabd32000d3b18b1130742772e' ;; \
		x86_64) natsArch='amd64'; sha256='764ee4a9761185f92904c21c3de204c8b898e9a6bad6afac8b1fe512ce887417' ;; \
		x86) natsArch='386'; sha256='a8067d9f26007bed3df2a72eebd4a813035a473058db1451d615ef5e96b30577' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.zip "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.zip"; \
	echo "${sha256} *nats-server.zip" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp unzip; \
	\
	unzip nats-server.zip "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server"; \
	rm nats-server.zip; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rmdir "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
