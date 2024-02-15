FROM alpine:3.19

ENV NATS_SERVER 2.10.11

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='52e603af6c249b716509ad7effb32033560e93578558c9e39420c15ab8d35fc5' ;; \
		armhf) natsArch='arm6'; sha256='cf9d1668e00efba64e5f9bef36d950fcdfc99b99ec436282da2207ddbf63d35f' ;; \
		armv7) natsArch='arm7'; sha256='582e77659441481f9a0dcd5bb3a8337137120448036db8601713b1769e19d1c2' ;; \
		x86_64) natsArch='amd64'; sha256='4b85a83a8d3b5f919e4915fc68a43186eda37eb2f7b893c1690b3cabd1e24562' ;; \
		x86) natsArch='386'; sha256='765acca88e27db4052b22eea63422f501e671a257da49bf955a54a52b2e314d4' ;; \
		s390x) natsArch='s390x'; sha256='e534bcc6ee8d70090d8b60a0686970b1d6a0a79df2acdb32f367a4e9589e19ae' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f0dd6e4c8c2e1c1bfc4c058e7461bb776e62473cc35f12c8db844e2a57d4eb1b' ;; \
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
