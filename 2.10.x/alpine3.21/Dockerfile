FROM alpine:3.21

ENV NATS_SERVER 2.10.24-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='5092a6b38401983fd95e51e7b13cdd46a3fb6bd3dee1ff3d206587382fd09386' ;; \
		armhf) natsArch='arm6'; sha256='80e14818b327bf3c387f8fc68ee0729a163186dcc3fe997c866342af9ef636ab' ;; \
		armv7) natsArch='arm7'; sha256='ad302db517e140e23d05b1254a5a34b48bcf47fee5fcbdfe0ecb5614ed49d151' ;; \
		x86_64) natsArch='amd64'; sha256='4d33e2f033ad28ff76bb2f519797cbe7ab4888471aa8ca5585b9f024c9c575fe' ;; \
		x86) natsArch='386'; sha256='677b1ddf5a8f541b847d44c5cdf850dbdb837c689b61f2a7ec369faacfb023ff' ;; \
		s390x) natsArch='s390x'; sha256='222e8ee832d7e5090fe9254c10cad0163d0d227a70e815c6061c13f82b253349' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f8cb5021a72661fdd9f6966b985f3dd5f36c91b92b44a187b654cac1c86319da' ;; \
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
