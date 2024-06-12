FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='16fece82350130729cb723d6c553e3ef743c145acd20bb085d693a7fd1823b92' ;; \
		armhf) natsArch='arm6'; sha256='ce38fcc1b99f03c3745ff99acf583b08e0ed81247ed74314057940be9d88fb8b' ;; \
		armv7) natsArch='arm7'; sha256='2b139c22b8e19f16aac83a7279fe398fa241fe558e1b23095e2ccb7b362bf59d' ;; \
		x86_64) natsArch='amd64'; sha256='a78037db6b39c9414c4cdda0659b8936ea3ecdd56665385847c9ba645d5ac8d2' ;; \
		x86) natsArch='386'; sha256='270f12d6d4b41cf9d3c09985c93c9e5f766f48f11829dbf3e36452d9b0216298' ;; \
		s390x) natsArch='s390x'; sha256='e81618a2c0a3e19ab128cf6aec70d49b1f52e153aeef9a7f18b4256e19f62091' ;; \
		ppc64le) natsArch='ppc64le'; sha256='385f35eae1bab92ade1e888e7816eb076751edb613daeb8ec5cc335c869bc398' ;; \
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
