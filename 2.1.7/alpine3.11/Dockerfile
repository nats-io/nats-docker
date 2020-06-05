FROM alpine:3.11

ENV NATS_SERVER 2.1.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		arm64) natsArch='arm64' ;; \
		armhf) natsArch='arm6' ;; \
		armv7) natsArch='arm7' ;; \
		x86_64) natsArch='amd64' ;; \
		x86) natsArch='386' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.zip "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.zip"; \
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
EXPOSE 4222 8222 6222
ENTRYPOINT ["nats-server"]
CMD ["--config", "/etc/nats/nats-server.conf"]
