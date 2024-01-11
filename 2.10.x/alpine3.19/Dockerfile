FROM alpine:3.19

ENV NATS_SERVER 2.10.9

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='7cfaa8547137e6df8b791c831fbdda49c527ff6b81ce71f4ece085ac993df9d7' ;; \
		armhf) natsArch='arm6'; sha256='d971b43a59dcbc99e2fa2b18fa3595de2de510d8562a77b8e40f1fea1c6de469' ;; \
		armv7) natsArch='arm7'; sha256='a84e3794f0e4a94e211499c0af6c60e0135eab505f03d0d568dec3ba3cfffbab' ;; \
		x86_64) natsArch='amd64'; sha256='5920e2d3935c1a1f19aa7eeaab95dabfe4cd0b98de7417b9af5023361de92626' ;; \
		x86) natsArch='386'; sha256='56a1e8491102f32e78d15ebea619fbef59d5a470a8655ab2417c41eb51229098' ;; \
		s390x) natsArch='s390x'; sha256='2fc697734b08bfcb53b9be613518ecf611d631c4dd39fa4874265830487188a7' ;; \
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
