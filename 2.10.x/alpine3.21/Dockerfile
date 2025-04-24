FROM alpine:3.21

ENV NATS_SERVER 2.10.28-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='77e43dc18b8133cff6958bc79191994fdcbe96c1cfadad92dd6b9acc12b37a95' ;; \
		armhf) natsArch='arm6'; sha256='762223826448e7701279a212301e27c1a973302d7c55b52c46d59473b9286067' ;; \
		armv7) natsArch='arm7'; sha256='594f698fe4e453ec01b945cc36a74ba029c1631829cadeef9db9bd4d741c6d3e' ;; \
		x86_64) natsArch='amd64'; sha256='82760e84e48bf3644055da500fc6eb740dd9546dd4f07f4c1b74f06ab18a1982' ;; \
		x86) natsArch='386'; sha256='bea9e3d0d1a9fc94661a2c5e56a105648b50fd9f62c504137a2afd917a33affe' ;; \
		s390x) natsArch='s390x'; sha256='8e18c2ae24230b939006f7d1b81b973ea668309c347f1b4271dad62d1c72e300' ;; \
		ppc64le) natsArch='ppc64le'; sha256='aaff4b6941278bd2ed0a11debfaf13005281f98f58b68253ed5ac65e4ab9b263' ;; \
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
