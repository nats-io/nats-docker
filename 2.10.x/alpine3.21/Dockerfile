FROM alpine:3.21

ENV NATS_SERVER 2.10.23-RC.10

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='7602085196c1083fc62a99cc2b790f053dd6abcbf679d9b3e814662dc6913474' ;; \
		armhf) natsArch='arm6'; sha256='b233a72782970b296b70f1b65317055fc5e7304cae687f7ae855192dd651f279' ;; \
		armv7) natsArch='arm7'; sha256='79b600f0c20027d963b1234f1336cac9a254841bcac5ed0269072ab94c4850c2' ;; \
		x86_64) natsArch='amd64'; sha256='bafdde0fcbf9842e19f9fd4023b38cdcf4ec562235c0dedaed37d37a8e87000c' ;; \
		x86) natsArch='386'; sha256='32601a2d7ef7d3cc540980efb2c598d1de8d7a1c5b4c8b9661711b0f3bd62963' ;; \
		s390x) natsArch='s390x'; sha256='dc8e992031aaef29b2b9658e36e5fbc46292d181c7ba4c1ee78e45b9f232219a' ;; \
		ppc64le) natsArch='ppc64le'; sha256='152778ff61191b8be54af919670587e4ac6f6afc5dffce6b921054233038cd1c' ;; \
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
