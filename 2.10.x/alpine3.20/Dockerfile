FROM alpine:3.20

ENV NATS_SERVER 2.10.20

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f12b65d736dcd6c58d1cd39a2378a1c72041b3b2ba158ab9665cac137c4c7be4' ;; \
		armhf) natsArch='arm6'; sha256='ad74598418d186e51562bc8419c5cd481e06ab0374848b7bb31271c0176ebdb3' ;; \
		armv7) natsArch='arm7'; sha256='acc0c0a628252a5b6b5bf663f149626072041d7e7b9c18f2c6611769041ab8fb' ;; \
		x86_64) natsArch='amd64'; sha256='979c6e633fb03987771b8f7baf99041b574638486ead35acdb868f6a7187a164' ;; \
		x86) natsArch='386'; sha256='715663e909d86152698c7fd12d42a06da580f0e9aa205582228237bbc2d01d9c' ;; \
		s390x) natsArch='s390x'; sha256='725df3feb668c5c44cdcbe5e6e0d080ee4c51e034c83b596a111b4473dbbf078' ;; \
		ppc64le) natsArch='ppc64le'; sha256='1acac043d7b66ee2236615bf526df8a013bd292bca2ca6f3b59eee8456b92468' ;; \
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
