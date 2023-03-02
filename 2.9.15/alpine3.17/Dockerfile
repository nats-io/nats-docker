FROM alpine:3.17

ENV NATS_SERVER 2.9.15

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f4f86a5c10914bc6fb40effd2fdaa3d4f69bbbd14ca68571c4afe49c7cd1356d' ;; \
		armhf) natsArch='arm6'; sha256='29c8e26624011d05a2befcb3a25d00eaae098baba34f02e93cc3e336b6aa61ec' ;; \
		armv7) natsArch='arm7'; sha256='83b6c1cb1b9d7d15b6fa042b63bd4af1cd66884d1b46849ba362b171611c19ad' ;; \
		x86_64) natsArch='amd64'; sha256='32ba26c522b3c245f2105e9642256b0bd8f993f3f9a034b701a327721576d761' ;; \
		x86) natsArch='386'; sha256='b32b54780fdc7527e0414a852effbbfab8e2c3f3482935b9459f586095e39945' ;; \
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
