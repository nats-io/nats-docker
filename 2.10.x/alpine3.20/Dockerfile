FROM alpine:3.20

ENV NATS_SERVER 2.10.18-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='3fb441d9a1614f3e385d9f1e7e8b43e2ac5155da5746983cf073924a8a364a95' ;; \
		armhf) natsArch='arm6'; sha256='97cb34cab0129a75934dbc7a6814d911cdfbb8b6e7ed8b7912fe558f783fb492' ;; \
		armv7) natsArch='arm7'; sha256='98afce36e712b960dfb5fd3db481a9c96799975b77b4371aa215a1a0252c99c1' ;; \
		x86_64) natsArch='amd64'; sha256='264167105ff1d7f346c0b20ca7a65fbde3fc18ffd44a9e4acb5403fb4ceb244b' ;; \
		x86) natsArch='386'; sha256='bb380804c47fec2ebd472e6d5154816df08f111f10a6541b2b89ed94c7082bd1' ;; \
		s390x) natsArch='s390x'; sha256='046fa11d1832ab49a970bee070cc64815e7edf11fd5f1cb329d716b18922a073' ;; \
		ppc64le) natsArch='ppc64le'; sha256='7e06b807648fe6918ba935dbf88bf4690d041bd8f3081765aac6c9ef888f484d' ;; \
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
