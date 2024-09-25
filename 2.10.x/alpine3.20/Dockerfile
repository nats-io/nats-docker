FROM alpine:3.20

ENV NATS_SERVER 2.10.21-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='edea96e33a1bf2b69968a98c13c1f857af48b4b5e3f85338a5215f496f2de3ea' ;; \
		armhf) natsArch='arm6'; sha256='de24715a8eb56923dffac8d882afea52b1804e4f41bf7640f119a8fd634150ba' ;; \
		armv7) natsArch='arm7'; sha256='86bfc37c085cf5235d18084b70d92f8bd58c212e26fe7eee6ac01119727ba855' ;; \
		x86_64) natsArch='amd64'; sha256='f11c4d59f15efefaa014b9f51f7d5fffce22bb7f18c90088bbdf0deb99ec9359' ;; \
		x86) natsArch='386'; sha256='cff53512ebd32c55cd4b5489f14b6a4fa5b6238f81826b4e8346caf203919f7b' ;; \
		s390x) natsArch='s390x'; sha256='7764f3bd82af955c961cec2c4273dbd7b93e59c30fb0ef749541234299d35447' ;; \
		ppc64le) natsArch='ppc64le'; sha256='68e3765a439556425717379f65c409e3c023aedb8d2b92b1d638ff9a19baef0b' ;; \
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
