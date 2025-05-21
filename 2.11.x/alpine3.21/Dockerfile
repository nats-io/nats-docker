FROM alpine:3.21

ENV NATS_SERVER 2.11.4-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4a5a8377295a447d23e9e7c212fc4d038a00f8c96dfbd51f90b157187bc82cac' ;; \
		armhf) natsArch='arm6'; sha256='744d84c3c19393a9be58f9f0e29da78403ea5ebe080dc320d6f1394743e60291' ;; \
		armv7) natsArch='arm7'; sha256='a9097183165949f9edd3e474a2bfbe30202e1edac91fc3bfb993bcf5a0cfc5c0' ;; \
		x86_64) natsArch='amd64'; sha256='d7b9db93a4f1ef6808b6117fd504765a6b090f2d6d4652f912d50d86e24421df' ;; \
		x86) natsArch='386'; sha256='abfc52902f6d4c5f8b7865ca2a8ae35cf23d942d51069d8b7b924fdf220de8fe' ;; \
		s390x) natsArch='s390x'; sha256='b0f75c615a862ae2563864f1604eccf47f05a8f141fed4886574b19962877cc0' ;; \
		ppc64le) natsArch='ppc64le'; sha256='8afd4bf4801dbb032c32d695326b0f12177ee18af4402638a2d7f8b5b900a2e7' ;; \
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
