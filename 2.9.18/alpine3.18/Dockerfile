FROM alpine:3.18

ENV NATS_SERVER 2.9.18

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f5ea0ace65873cf81dde2951d9130f6ecad3f96e80a59badb259a66fc3294579' ;; \
		armhf) natsArch='arm6'; sha256='f7dd549c09bac2adcc3260868bf5f182645c8e59e7b9cb868feff244017998b0' ;; \
		armv7) natsArch='arm7'; sha256='bb1015887864e7eeeeb8bef4c9e06bd20d865b01a67bab8bab802ef5483bb6ad' ;; \
		x86_64) natsArch='amd64'; sha256='c61c5dd662ed0836d752ed98508d5a7328d85e6126d2cf9784a0d546a64c961c' ;; \
		x86) natsArch='386'; sha256='68467b7d83a96a554257b84464bdff34de956af93971e43faa711e1cb29249c8' ;; \
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
