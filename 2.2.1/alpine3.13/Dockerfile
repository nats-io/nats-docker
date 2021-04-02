FROM alpine:3.13

ENV NATS_SERVER 2.2.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='0123d924907282265190258662edf8ad4351055083b5040e3bdf59117bd1c51c' ;; \
		armhf) natsArch='arm6'; sha256='da719b07fd57137f85bfa6cffc7d00841a9c1fb4cdf7ca9a537bfc3f99b71f36' ;; \
		armv7) natsArch='arm7'; sha256='cf6e8d9a9cc5d05f7320fb4be8fc9239cb87b91c6600a61ce7a2fb63e2f29f5a' ;; \
		x86_64) natsArch='amd64'; sha256='70cb40d78b82ea6c0ca926c31ef98d2e1c885cfe2f73f34883e4ca448366c2dd' ;; \
		x86) natsArch='386'; sha256='da54d129f8a52c048ded61e3b62e946037a9464d02cf818e568bbf1e385ce6be' ;; \
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
