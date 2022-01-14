FROM alpine:3.15

ENV NATS_SERVER 2.7.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='411928ee9d180a44d9b8f28d3f85f34167f245792a9262fd268881bacd802c9b' ;; \
		armhf) natsArch='arm6'; sha256='6fb74518c6f88c29ae9bac0d78db7d64bec6eef9972d5c643cb6e46c3090b67b' ;; \
		armv7) natsArch='arm7'; sha256='79f292485c6a14b7a797119eb9a5cea92606dece31ef660e76255c69a6f715cf' ;; \
		x86_64) natsArch='amd64'; sha256='b417e27fcec636a8f441788476a6e41b983ce2752793a9a8136ad48e616881a4' ;; \
		x86) natsArch='386'; sha256='740afb36dc0d97f51ff7bd9286aa2b9d836b14f1b9f48b2113e7aacc17e6d508' ;; \
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
