FROM alpine:3.20

ENV NATS_SERVER 2.10.22-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='055a73e01f32b4394dd4d263a02be51e6e4208f81d74bbbfa5a727e51312ac1e' ;; \
		armhf) natsArch='arm6'; sha256='af6a70bcc2b522be869bd77cd94ba37a9e1edcd84b03a27a8baed5491f7818f5' ;; \
		armv7) natsArch='arm7'; sha256='446faac3ee360832accb03a07e8456e5ab5611e1ce0cf84ef428efd82964faaa' ;; \
		x86_64) natsArch='amd64'; sha256='638473ff5ac1fe759e2b04ccc1bdab38aa153dbb0522109114689e77de683385' ;; \
		x86) natsArch='386'; sha256='7531dab77ed662431330f064918a3cdfe21f2a59aa59e49b2a41265f046918b5' ;; \
		s390x) natsArch='s390x'; sha256='cb0ce8872a068c1052c65441176344896f89c74c092318af9cb9dd16d947240c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='c3edb6b404b5b31cb69269649ed0f882a3abb3ac83a1207a37c6deee1864d0af' ;; \
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
