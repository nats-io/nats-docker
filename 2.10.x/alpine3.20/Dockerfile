FROM alpine:3.20

ENV NATS_SERVER 2.10.19-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='dadd70b79239a136cb8f1650bdc29239501ee1d13c5c85bf63927f6c2ba3933e' ;; \
		armhf) natsArch='arm6'; sha256='25c88682b8219f742bca20f845763cc70ebeecddeb05c2fe653554366b32c3cc' ;; \
		armv7) natsArch='arm7'; sha256='5224c86dafddaaeacd208236faf48797e7b622ef486178a40fabdc1554d71164' ;; \
		x86_64) natsArch='amd64'; sha256='8b147d1e425eda6b894faf7646f672a6931ace7c3cab4876be8c4b6c800120bc' ;; \
		x86) natsArch='386'; sha256='c644531a9a4691535c067769eeee830a9abe6fc6e2e75192ec5e32992f8b997e' ;; \
		s390x) natsArch='s390x'; sha256='f76755d6234679a984a24e5c1b75333d80c540d46bbc1292f9cf5b35c92a9c91' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d7a9545fa77b274bd604c5b2e156471b88d2c4e5120e7a863be4755d2ad2b89e' ;; \
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
