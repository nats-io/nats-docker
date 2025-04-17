FROM alpine:3.21

ENV NATS_SERVER 2.11.2-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ccd818134cc7415c4b885cc330307aac2dce037100742a387869884c458a1e34' ;; \
		armhf) natsArch='arm6'; sha256='40735fc61f71a927e95b22c40b5122588c5996e47177e05c0160f6761f5b17b1' ;; \
		armv7) natsArch='arm7'; sha256='19fad8a7789fb1e0dbf0adad5ffcb2e9792e010285fc11821a604fdbd246da7f' ;; \
		x86_64) natsArch='amd64'; sha256='6cc9bfd3b34275af7745ef2833aaf164b4d245dd339fd115277541de8dcee138' ;; \
		x86) natsArch='386'; sha256='c4be0ced16789b5e9759f1d20ab3322a2d0b488bc6f42ce548d3af6b7978e435' ;; \
		s390x) natsArch='s390x'; sha256='13029c8009078ede78a52dca2ea7bc1ec539a4ef94a0d231e08796e9bef2a42a' ;; \
		ppc64le) natsArch='ppc64le'; sha256='022c232a980372f7da8d5968e7f37341dccf2def1e10151480f13c955f14e3c5' ;; \
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
