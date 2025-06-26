FROM alpine:3.22

ENV NATS_SERVER 2.11.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='340fc1ef4162df1c597ef2a13b375b2efe6769d44371b3f2a89969027ece9d8b' ;; \
		armhf) natsArch='arm6'; sha256='5beba27af67281eaf42b9c1fc7e91eba276569fad5884342711c44ee9cb10409' ;; \
		armv7) natsArch='arm7'; sha256='011498aba59007407523776b14f6f3777dd9afbec7092f8d60c92ce09dc552cc' ;; \
		x86_64) natsArch='amd64'; sha256='b89a758f6d9fe294b9bb3d10982efbf5709f4a21fd6b0a702c2e8e1e265affec' ;; \
		x86) natsArch='386'; sha256='e5bbb34f6b2b71339daafb6711e2ee81f1ee63593df9f4bd0bcbd29d6e023b2e' ;; \
		s390x) natsArch='s390x'; sha256='6e257d30747950d4886f4c88cdefeaf91f3cf4425257cf63f421f32ebaff5e1d' ;; \
		ppc64le) natsArch='ppc64le'; sha256='be9d1012adbeb51b7c7e155ef2199e8fe7db50b09569a1a97acaa76ce6f88786' ;; \
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
