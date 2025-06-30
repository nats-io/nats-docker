FROM alpine:3.22

ENV NATS_SERVER 2.11.6-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='921964fd8ba13834bcaf264597022e1ba8221a37c63f51a4b421dbe601f5f378' ;; \
		armhf) natsArch='arm6'; sha256='b54bdc467eb6b701f1a949130d04ef05538782427d780779389f8441426aedcc' ;; \
		armv7) natsArch='arm7'; sha256='c4df30c89707f23575158b16f59b84642391147952c97e11a8938c3448a48e5b' ;; \
		x86_64) natsArch='amd64'; sha256='48faa516988ee9ff2058ba74e599c44365dcf6caf6f3ec31d7494bce24f60fc6' ;; \
		x86) natsArch='386'; sha256='1b49e3ea869f397c817f4b001d99419ddc4101fe68934d0f44ad7e192d2d267d' ;; \
		s390x) natsArch='s390x'; sha256='008946cc5c0b9b0d038c31e5ecbb64edd69942935f0627423bf0e674a1b5ed1b' ;; \
		ppc64le) natsArch='ppc64le'; sha256='ad8c89351a183f6a706a4ab683b750a7524c3cbc58d386c9df65dbc486791de1' ;; \
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
