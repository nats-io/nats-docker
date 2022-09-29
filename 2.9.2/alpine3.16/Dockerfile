FROM alpine:3.16

ENV NATS_SERVER 2.9.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='a2c6ff2c7342198ed61136658310a8f3c336426b07062ed0a073c617ddf4b503' ;; \
		armhf) natsArch='arm6'; sha256='918ee03dbc6ab17339f7510940945cdbb07fb15e5599b08961b17e732de0308e' ;; \
		armv7) natsArch='arm7'; sha256='2de2669cd17d8c5ad118d7b1b45dbf84fd2ea2baad728cca971df09715086760' ;; \
		x86_64) natsArch='amd64'; sha256='7f8f9397247ed5c69eb1ecee25ef5181be822eb85645451389f11dfc9680ed6e' ;; \
		x86) natsArch='386'; sha256='dc8793a9778fecd44d71837ecd52174aec79d2115eb895373cc9dd7797d8b6a0' ;; \
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
