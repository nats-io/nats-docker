FROM alpine:3.14

ENV NATS_SERVER 2.3.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c8ba676a6c4ec9d3088e0b64ffdae36e2f2a9e1b89f030799f3efbb2923524a0' ;; \
		armhf) natsArch='arm6'; sha256='d1f14441d1fbd53a7bff9623e8e572707d3e7024b42b6e925ad371d4dec0bc47' ;; \
		armv7) natsArch='arm7'; sha256='2488706de91e94eba477ddbc3b293ec0b4d823509656cc101eec6a07e0319bb5' ;; \
		x86_64) natsArch='amd64'; sha256='8c11abdeca4882888a8b6fbc45effe9fb4d1070eda3939b7299892c8c69a3e87' ;; \
		x86) natsArch='386'; sha256='010bca73095d8a05495ef74a112dfd3919925b0ced10bc4c5f876f3858ca41f7' ;; \
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
