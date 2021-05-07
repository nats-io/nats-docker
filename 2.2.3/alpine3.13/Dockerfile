FROM alpine:3.13

ENV NATS_SERVER 2.2.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6fc1c02eea8b376f9a2547b8129df1dccf2773490e4e3a85a743152d45dee4e0' ;; \
		armhf) natsArch='arm6'; sha256='bc0d25a9e1cc37f3d859c135581b0ee2c6af6f86e0c1872e79a842d03ab6dd8c' ;; \
		armv7) natsArch='arm7'; sha256='7d30205305a4ef20cc1b39894e9e7404058ff560cfd7ee90fc9b530a794b743a' ;; \
		x86_64) natsArch='amd64'; sha256='818cf5079dc19d39bb22cf9f122ae5191f62d61619114c1b58ce00ba8a4e2517' ;; \
		x86) natsArch='386'; sha256='81071f4c7ef5277cd29880cac2e0731de906ad1932fa2ce94641b455f2bb42f2' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.zip "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.zip"; \
	echo "${sha256} *nats-server.zip" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp unzip; \
	\
	unzip nats-server.zip "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server"; \
	rm nats-server.zip; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rmdir "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
