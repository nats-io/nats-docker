FROM alpine:3.14

ENV NATS_SERVER 2.6.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ff37771c0442e5921dd6867ef712c4029375a134f478b45469f5649b31ca06ae' ;; \
		armhf) natsArch='arm6'; sha256='47b58410696fc2bbdd4b0c604f8a6df74b348bcf56efcff739a84f8c3da16f22' ;; \
		armv7) natsArch='arm7'; sha256='071a52917aa7931dcce84d052e01310edd82d7399b5d699ddf9ad981af58fa5b' ;; \
		x86_64) natsArch='amd64'; sha256='8a81d7c2c65f698875f5ed36cca842e37e51eb9bddb2374690d49bdc782aa6f5' ;; \
		x86) natsArch='386'; sha256='659e085ed13d51acf52468e6e44257bf3dac3111ddf90ba065beb9a3c0a71b32' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
RUN adduser -g '' -h / -s /bin/ash -H -D nats
RUN chown root:nats /etc/nats/nats-server.conf /usr/local/bin/docker-entrypoint.sh
RUN chmod 640 /etc/nats/nats-server.conf
RUN chmod 750 /usr/local/bin/docker-entrypoint.sh
USER nats
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
