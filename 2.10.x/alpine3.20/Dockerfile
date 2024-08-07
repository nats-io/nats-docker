FROM alpine:3.20

ENV NATS_SERVER 2.10.19-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6cad7d8dea57474c63f356e5a26cbb48b0e3ffb55dc153dcfdd6f351034bbf48' ;; \
		armhf) natsArch='arm6'; sha256='327474bb7cd7b1012581e7e36db30537407ee5895280c7385ef15ea22cf1b4dc' ;; \
		armv7) natsArch='arm7'; sha256='09027807294cda21f7197bc46dd6b5ba8520b8a747148cb157db0ff587ba8387' ;; \
		x86_64) natsArch='amd64'; sha256='dca1c09dd010cc88400bebdc994b68c267732ddb968d70c102e3b4dc42dd89de' ;; \
		x86) natsArch='386'; sha256='5e8ad3aaf715a47e7c20c72dca322c8269952243694b442db2b55689334f90ef' ;; \
		s390x) natsArch='s390x'; sha256='1f22f1dc74ca29fdcb827166266b5c792901ebfc5bd51228aeedd7172f769289' ;; \
		ppc64le) natsArch='ppc64le'; sha256='e3071c80fcc6b1e71d6baad4780b52e7d4ffacd320823438da69131eaab3217a' ;; \
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
