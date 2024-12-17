FROM alpine:3.21

ENV NATS_SERVER 2.10.24

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='a4ae6c46ef545a13a3214bc35696b2806e05b60742f7ed5b2082d3c2f5af854f' ;; \
		armhf) natsArch='arm6'; sha256='0061ec69127c1d321af8139a6bdda4e1222a3cfe1ad2654370420734ec735171' ;; \
		armv7) natsArch='arm7'; sha256='344d4da46b21291a992a3ed7bbb2ef31539aa7193b6c5936a356be9590b0e961' ;; \
		x86_64) natsArch='amd64'; sha256='ee6500f364e3a741b496ae0296c04f2a9d53bbaabac457104ac74596b4a59d85' ;; \
		x86) natsArch='386'; sha256='75edd97f98fd0735b2288fb0c0eb6dbceb4e94015390ac4439587fb25ba99044' ;; \
		s390x) natsArch='s390x'; sha256='767e2a0f06030ad8c83946e6a5a8718868b88cd5b60958d217d1fdb65024ebae' ;; \
		ppc64le) natsArch='ppc64le'; sha256='2c3582f1e9ec7f43e63846d347655035017ca555b33831e13783396774f2d206' ;; \
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
