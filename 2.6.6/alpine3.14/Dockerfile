FROM alpine:3.14

ENV NATS_SERVER 2.6.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='70da0ad3694aebfc742f9aae919d3a4aa5b8c863946e99c5d332195fbbdad49c' ;; \
		armhf) natsArch='arm6'; sha256='e2cc1e198d5d5c83e2f2c2dcb15fafb71601603e3740065682812afaa7dd443a' ;; \
		armv7) natsArch='arm7'; sha256='f3698a4fb18c6664d477b920d5f07637141a6623cf2fa998900155fea0d97e61' ;; \
		x86_64) natsArch='amd64'; sha256='2c2fc16322fb2bc0b166ee2a01e163d4beb2cf7b49d083cebcd36695dc05a381' ;; \
		x86) natsArch='386'; sha256='1da03b0d163dc98209f010bf6efa5fc6c81a23b4bab7a98bebe142e19fc26bdc' ;; \
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
