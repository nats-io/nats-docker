FROM alpine:3.21

ENV NATS_SERVER 2.10.28

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='78f9b382d468f7b683bf8bdda2c6276de1fd230d9d19724485f48b327d7ed4c2' ;; \
		armhf) natsArch='arm6'; sha256='2a29a87abdec21bff9fb19a30aa06af12a6db31ec32d0b3de1a7c8bdeeb74b19' ;; \
		armv7) natsArch='arm7'; sha256='837db6e72894993bde7f0e402f6f9dc151d8452b0441cea630260764bafd4c84' ;; \
		x86_64) natsArch='amd64'; sha256='52e3baee2bf9cb4f3d362e293538e9f11ccfdb22ac9fbbd2bcad790e3ba41e3e' ;; \
		x86) natsArch='386'; sha256='ffabdd7c124951b68ed4501223d5a877c3e90c5da68c27c884a58806eaa1c369' ;; \
		s390x) natsArch='s390x'; sha256='f5627e4db5746200f62e6d5d9212dcfc59a4d4dc9cee30abf8eafdafac5445a1' ;; \
		ppc64le) natsArch='ppc64le'; sha256='096424d6958c7b2798027208d0cc0c2ea5632e5530fd94d66712d586ca6d6d27' ;; \
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
