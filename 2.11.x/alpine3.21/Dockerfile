FROM alpine:3.21

ENV NATS_SERVER 2.11.0-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='25df6872e910a959976b5d0e2a2f60fec53e12e3e4b582d8f27fed2c9b3906bb' ;; \
		armhf) natsArch='arm6'; sha256='0058d266c50ec693151677c9a98aa4043810bd10ee1a16f4c4edc708a697e874' ;; \
		armv7) natsArch='arm7'; sha256='4d1922d1840452fe45968011a7366988f0da376a59dfdb7f9e47987627c703b5' ;; \
		x86_64) natsArch='amd64'; sha256='e0311cd69df73fa96497e91dd424892cb1dd0d4ce5155f9a605b66bb543b9c06' ;; \
		x86) natsArch='386'; sha256='250a20b3eb5d345c2b921844d2b5547ac3a138578c84c6c40f2f433dd92e2473' ;; \
		s390x) natsArch='s390x'; sha256='a3dce4c2fbb6ccbbb5534f3d40449669f5e7b8a2798a4e8aaf5fef64188fea4d' ;; \
		ppc64le) natsArch='ppc64le'; sha256='036119bb99a6b3e38f7739509148966351da044584608ef577b63d798bab19ce' ;; \
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
