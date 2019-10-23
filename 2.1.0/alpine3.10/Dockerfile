FROM alpine:3.10

ENV NATS_SERVER 2.1.0
ENV NATS_SERVER_SHA256 a4012cac52715dbc693dbc3a98b90369b132416b12a67f9bcfb24c18d1efcbd6

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
	echo "${NATS_SERVER_SHA256}  nats-server.zip" | sha256sum -c -; \
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
CMD ["nats-server"]
