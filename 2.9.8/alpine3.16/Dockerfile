FROM alpine:3.16

ENV NATS_SERVER 2.9.8

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='0d5ed2d72a3b294519ebd9aa109b4a6dde8f6782b080119b074a18e91230475a' ;; \
		armhf) natsArch='arm6'; sha256='254c5d3dc48a462ed98fca8903977d4adf07c2ac53032fc8308a65666e90e482' ;; \
		armv7) natsArch='arm7'; sha256='5caf555fece68e05d4e93cb128bba8383a24239f6caa45d9b3c7448586b10d29' ;; \
		x86_64) natsArch='amd64'; sha256='0f60fe5abfaad53f96eb0f92fbd787bd721255ce67fa8aff3b6a1bf06c85a571' ;; \
		x86) natsArch='386'; sha256='37618b46dee7730f233ebc88314e0ac0d387a44da079b5b6394ac817280904a9' ;; \
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
