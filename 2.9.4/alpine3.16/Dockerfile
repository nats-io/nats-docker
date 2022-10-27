FROM alpine:3.16

ENV NATS_SERVER 2.9.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4f7a05ed80b8c235b8dd706b49c8b3810680b3cb005ca9573e69362927c211bd' ;; \
		armhf) natsArch='arm6'; sha256='40d88777c384d035fa2c7a96d885e31240bbce8a907e96821ac12f8c17d3a471' ;; \
		armv7) natsArch='arm7'; sha256='eefa52c70486859f963c0d922a0d69929737caf83006c7d642f94ea61bdbe07a' ;; \
		x86_64) natsArch='amd64'; sha256='a2fa39fd0f9e4526f08e309bdced1450b9305674772815838f6db6adc5e99a9b' ;; \
		x86) natsArch='386'; sha256='f2a1b755ce1bbd346a8b3415bb8d71522fadf6f3a58fcd92a598be2232318cb4' ;; \
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
