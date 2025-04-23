FROM alpine:3.21

ENV NATS_SERVER 2.10.28-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4253c86914ef6759b527316886e15b6af046fe302413ab987edd096bdf02236a' ;; \
		armhf) natsArch='arm6'; sha256='1c6c5b4b2cff13696affad77c2ebb228a4cfdfe159324c4cd356e1d65224d607' ;; \
		armv7) natsArch='arm7'; sha256='4f7f10b172ba1a17f3e6d06e61baec86ac4f077575cf41dee70a9bc8144df393' ;; \
		x86_64) natsArch='amd64'; sha256='65df3a8eda8f5838089a2a22276f19607912245a3d4d3bdd293c3146a8f06260' ;; \
		x86) natsArch='386'; sha256='6af4e1b6e70c3fac904528bd78a8be4ce45d0f5d159e7242fb96bfa40e8d11e2' ;; \
		s390x) natsArch='s390x'; sha256='0c46f2a0b2068b7c2831724b22c4dc3fa74be2d05acd7e70a420c9d577a20312' ;; \
		ppc64le) natsArch='ppc64le'; sha256='93b0e61abb37e04eb11d7b14af0b236e69cdf50694251183dc48a08487725613' ;; \
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
