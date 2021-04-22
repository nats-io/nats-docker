FROM alpine:3.13

ENV NATS_SERVER 2.2.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='761b07893a86d26fd1defa058fcd4aec624e04c1d1063cb7fae6c9225a760884' ;; \
		armhf) natsArch='arm6'; sha256='73e7fbcfae4b35695007d0a42c3553ee3f37b78e386e85a3dafe733cb07a3be1' ;; \
		armv7) natsArch='arm7'; sha256='7f611c596cf34f96ffd8185b9e4be917bcaf377cdaf23bef2964a3d6348b50ba' ;; \
		x86_64) natsArch='amd64'; sha256='21c980037f776d0402fce81fef1e1a4a4b55648131cd9c6c18f09165eefcc16d' ;; \
		x86) natsArch='386'; sha256='59f193d5307f431b5293566ef180bc0f51090246bf9f31e5fffdf6e22f58f643' ;; \
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
