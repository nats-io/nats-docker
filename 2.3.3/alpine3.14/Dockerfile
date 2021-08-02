FROM alpine:3.14

ENV NATS_SERVER 2.3.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f8e04470165fdfba062442cf5975f22668ab20fb12df7e299734e16a45370bef' ;; \
		armhf) natsArch='arm6'; sha256='6396531f34e99cca903cdd461a79f1b8255d0cc219e5186ea15284b5b5e7e5e7' ;; \
		armv7) natsArch='arm7'; sha256='4353de84d9e42b24b73ba98a4ed2a9eaa7c4f945bd68e1ddb4fbde885020ab30' ;; \
		x86_64) natsArch='amd64'; sha256='66703b81de34d06060eb2198dfb5a1087547d45e680dee4da1214198a8073ce5' ;; \
		x86) natsArch='386'; sha256='e38b9c9eda279bc4eee9cf6a3d4b2b25774b692450421a16e2ff6602977e6571' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
