FROM alpine:3.14

ENV NATS_SERVER 2.4.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='eb510dd016cb1a9e9b1fae88a3471029048cb75dcc4ad83a4f5b1e3665f24a20' ;; \
		armhf) natsArch='arm6'; sha256='76ac66cd86217a43bc227220eb054aac8a5744890d43c76156075d68a684d9e0' ;; \
		armv7) natsArch='arm7'; sha256='e7521841d59f55fcef6172aa8f22d3af7ba1776bd67109a23c29d34d18d44bd6' ;; \
		x86_64) natsArch='amd64'; sha256='f6841c89fcf99302bc7ac295ddc1e75322385f861d55abee79733976c8eb9bc7' ;; \
		x86) natsArch='386'; sha256='c7e6e2b73d402e841b3abb57e26e2ef53350b44e385255bf289b08182058076a' ;; \
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
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
