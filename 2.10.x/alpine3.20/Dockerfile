FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6e16844f1475c90e7753d97071122b0293b538dfb462b08eb302d8928d7036a0' ;; \
		armhf) natsArch='arm6'; sha256='147b1b9f2bdb17cf5c4a8518106531bfa9cdac184d45bd6e2f4afa5fabd41cd7' ;; \
		armv7) natsArch='arm7'; sha256='6ec8712756418bf6d17bb7eacc618b93339cf75d0c4fadf68f7f49a28badbf36' ;; \
		x86_64) natsArch='amd64'; sha256='157bbf148dba8a2ec639665fdbc1cf617dd6dc2eec524f3b2be38adcc25900c6' ;; \
		x86) natsArch='386'; sha256='1a96e4e21957032ab744077a9580f97b6ec9c436d3eb7fe9f8b538ce692ab0ed' ;; \
		s390x) natsArch='s390x'; sha256='c989900ceaadf6fd0b634b993bd595b863685dd80e3f87b35ba4c5893aaa4ffa' ;; \
		ppc64le) natsArch='ppc64le'; sha256='a1abe3e4aeaf07cfcc69a16c27a53500b6b1d67375f93f2ddb9f167274b505e4' ;; \
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
