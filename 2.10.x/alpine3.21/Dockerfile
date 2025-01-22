FROM alpine:3.21

ENV NATS_SERVER 2.10.25-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='55497bf72b9f25e5705c13b66cc731f671cb289627eaf947581d8bff6b502daf' ;; \
		armhf) natsArch='arm6'; sha256='169983cac88b04a4fab1c4a3fb88c2708538796c348ad89438e63d8d7ebd95ee' ;; \
		armv7) natsArch='arm7'; sha256='cf29659f7a23571300fed8e68648231e8c5259fc10278b77b71a0fb2e0fabd18' ;; \
		x86_64) natsArch='amd64'; sha256='8fadf8a70b9e449efa6e0f2cf6ec29e161a22c80c63bfe67e42f5982126129fe' ;; \
		x86) natsArch='386'; sha256='431b3cc068f15363fc4da0e5ca119898797cd5216f3a4970e8442592a02ee5ed' ;; \
		s390x) natsArch='s390x'; sha256='e6fd39ace66c420c849c707eb800a9d46cdf61fabe3ffb06d05b205e263d0da9' ;; \
		ppc64le) natsArch='ppc64le'; sha256='da0e95101d7d4118847e97eb38852c95337fea50b8e51440c4be286fa5059ee5' ;; \
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
