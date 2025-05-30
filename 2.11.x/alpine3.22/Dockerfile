FROM alpine:3.22

ENV NATS_SERVER 2.11.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='66b1ec828d78c3d24e207ad77239b2208d939c6bebd88fe0656be5eae325442c' ;; \
		armhf) natsArch='arm6'; sha256='89a2a3525e9c1882e69a3b8c7413887b35bce6badc7ed52434237e6f4201d6ca' ;; \
		armv7) natsArch='arm7'; sha256='244b122197847bce9ac8734d85a4e0d340e9eb6683903b74adf5d1e54e840b11' ;; \
		x86_64) natsArch='amd64'; sha256='84192cee46c62760d9c259a97f373b73bccadc41be779c26ef676542ae15daf6' ;; \
		x86) natsArch='386'; sha256='3f6bbd7ee8537e364681d60854f7c443b1395942cbf50cafa23b28d0e1e9b697' ;; \
		s390x) natsArch='s390x'; sha256='f04399991c43feed206d8ec77b748d3d4fdba2503f5153743f6f5f1937d1b1fc' ;; \
		ppc64le) natsArch='ppc64le'; sha256='8867a9368f2bdc12bf2ad9fbb7bb63c4c5ba32434a17b57175b443805b2c5900' ;; \
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
