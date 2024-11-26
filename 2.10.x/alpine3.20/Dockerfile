FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='cdbc97c00e8a5b575bfad605c61f6bcfe9d951652cda9e0b6995ba23da21bd29' ;; \
		armhf) natsArch='arm6'; sha256='85a3cf23531c2d2c6d9649feab5b404acf47f77837aa3693ee43f479968266c3' ;; \
		armv7) natsArch='arm7'; sha256='c4245441972df71ba013e6342867db4ee80042b949b65bc516645f0ae9ae1b3b' ;; \
		x86_64) natsArch='amd64'; sha256='b5568e13ae98cdd674fd022f390e120eade0ab36e372bb188773e5e33f995a68' ;; \
		x86) natsArch='386'; sha256='148f18b4c952296713ea1053741e6ded457046bd244fe8db09209b9a41c78470' ;; \
		s390x) natsArch='s390x'; sha256='7cf4b75235222daa1ccda81050df98083987fcf946e8cfbf937be281bf193c3c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='edc144e3ff595c94c2143c2efb0e4522a9bf99b9e50b78d86f0e75639848eba4' ;; \
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
