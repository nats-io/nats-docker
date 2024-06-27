FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.9

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='205121bb60d5bd18dddaa187195768494238cacf153f3f902ac9e7067df9f168' ;; \
		armhf) natsArch='arm6'; sha256='2cf8c6b8f05900454e1346ad9834f108f09e95f662e82e09bed06bf51d83c135' ;; \
		armv7) natsArch='arm7'; sha256='9aa242317fb6e99b4a053eddf5e23c03021f65b969ff40104d6bbed9155a9f60' ;; \
		x86_64) natsArch='amd64'; sha256='4e2879511cf65a197b06a98178a180308b58761df1baaafd91adfe45fd5ff55b' ;; \
		x86) natsArch='386'; sha256='23be3492469529353ad843ee8dd793555976e20006d8071cf1b78c66645ba942' ;; \
		s390x) natsArch='s390x'; sha256='64cdc66f9e30f356b3543a807a04a5a120c1af4ff5cae6ee325f4dcacf4550fa' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d9376d0b438065ae7e5293595c9a355b6d74bed021a75b8f0630f231f0a532f6' ;; \
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
