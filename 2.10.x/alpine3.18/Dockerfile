FROM alpine:3.18

ENV NATS_SERVER 2.10.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='59456ee8d222213c0f713e5b571156ec053db15288ee9035b3a7ad01e226c0bb' ;; \
		armhf) natsArch='arm6'; sha256='c12c5cde86dba95fa4b433b58af3b9568893e3c7814fa22feae85eb47a9bb2bd' ;; \
		armv7) natsArch='arm7'; sha256='748eb00c8d29c674bb4f98371a1afd8be9fba59336be9ef24d24fff148f1e7a4' ;; \
		x86_64) natsArch='amd64'; sha256='76f5798ba3923dbc4f170bbae0055d3267d5c604179b2c644f6e7c79cc970d76' ;; \
		x86) natsArch='386'; sha256='7f151267f76948293a5721e642b489e1135aecbeb2399dd23d00b04e6a609191' ;; \
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
