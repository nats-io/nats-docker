FROM alpine:3.17

ENV NATS_SERVER 2.9.17

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c7cf7bf8c029500d1b51773132ecc13a1fc89f2e080faa6b505da8cb95aa2a0c' ;; \
		armhf) natsArch='arm6'; sha256='b09812858f1c957fd1869e21d4b8d64b3b0d6cdf3abb34502167120640f1d5e1' ;; \
		armv7) natsArch='arm7'; sha256='970649306f45c78404c42dc5c0ab37fa6d5149501e47a68bef7841a06730a654' ;; \
		x86_64) natsArch='amd64'; sha256='4ad2d83dd2fb9cc44a7e078d2e400f37c188b8515100f5de0f10f0eefbeb6b23' ;; \
		x86) natsArch='386'; sha256='59c42f21bb6e8a5ef6e101ce6e3c29692b2cc9b1eb28465e67edeb391450626c' ;; \
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
