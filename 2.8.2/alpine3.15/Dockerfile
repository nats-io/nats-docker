FROM alpine:3.15

ENV NATS_SERVER 2.8.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='3409b9dc76c0136cecded67115521d3a815f7a2f3739e81eb87a8d5d761843c3' ;; \
		armhf) natsArch='arm6'; sha256='a3d474a583ca90e3577aa470335c582d4565918f500ebd28d760643fb631d8d5' ;; \
		armv7) natsArch='arm7'; sha256='88fd437f7def8dbe68b17dce703c919771e64b570856bf0e6f2eb3b9459031c6' ;; \
		x86_64) natsArch='amd64'; sha256='59805a464237801574ca7efdc69ebc21040e9b811fb53ed444c4808a05440719' ;; \
		x86) natsArch='386'; sha256='facd3c69ee27c3e9e8654e5de95eb79de2e873bf4c066317aa9fad5c2ea26b92' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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
