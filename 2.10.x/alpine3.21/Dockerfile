FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='fcc5917adbbf0c96b0bed253ecada972bd7c94f66d6e061b25ff0d575e901550' ;; \
		armhf) natsArch='arm6'; sha256='86bcd5abebe39a1125f8cc17feb0d726cfcb39e632c10fddbf0361696b4f7277' ;; \
		armv7) natsArch='arm7'; sha256='0e0b8d1ab5334f7e72b6ae7bd08e8e32a4d0be802349b13b1c9c530b62875f10' ;; \
		x86_64) natsArch='amd64'; sha256='b2ed20992aabd216bb83907e6e73052aaec90704e187ceaa1cb8c530ae360124' ;; \
		x86) natsArch='386'; sha256='fa60a4a4ece08b1ca2bf4eeb5b3d085d025adfa489397eded47bfa721ac515c7' ;; \
		s390x) natsArch='s390x'; sha256='646783ef853dac6bf51bdce849d4eff85ec9e67fd18b146bfcf6d2aaf3c36f93' ;; \
		ppc64le) natsArch='ppc64le'; sha256='ab763241b7ba34628a00c5b59820ad4427eac2116a02c057cf791b635478d7c7' ;; \
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
