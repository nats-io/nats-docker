FROM alpine:3.21

ENV NATS_SERVER 2.10.24-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='96316e6e73a634661384ae58cfbc20d25593f2c2f41e9efa62a96fbb0298baa4' ;; \
		armhf) natsArch='arm6'; sha256='234ed673715058466f5ea5e83d648839328bee26117aa5b61f341a19f2c7cfdc' ;; \
		armv7) natsArch='arm7'; sha256='97c4f0da67b6d908e0200c3ba39160c88ec54476fd127dd75dc1cd041586e6d5' ;; \
		x86_64) natsArch='amd64'; sha256='050e94385adb53bafefc26462ee8398130c0ccae394aab6bf28b920eb766e423' ;; \
		x86) natsArch='386'; sha256='11e37d39def6b349029f830d8955cdbfca19199b6c516d66073afa4a86f29fd5' ;; \
		s390x) natsArch='s390x'; sha256='2372b98e78ed80bb4eb88af1907229eb772579703a8f800e1300626065477e81' ;; \
		ppc64le) natsArch='ppc64le'; sha256='043b55cd01029b0db7956c7cd6516d31866aa2c0234d1ba4a87dca507357127b' ;; \
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
