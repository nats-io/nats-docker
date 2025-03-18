FROM alpine:3.21

ENV NATS_SERVER 2.11.0-RC.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='61d370fe8b2a92c73e10e384b8017928b1d58f13ecf13e92e4981bed0d170fd1' ;; \
		armhf) natsArch='arm6'; sha256='4236841b3a57a58539e10a98736972c7bcb04010ca9975d27e9b6791431d09d2' ;; \
		armv7) natsArch='arm7'; sha256='ddcc774cc75d339eb103a1144b7c34b9556c202820c26e800d8820fd6de28c18' ;; \
		x86_64) natsArch='amd64'; sha256='15ee32f9b75f0b5f8d9fde571dfa8c65d1ebcdb40002f8158c5394298d36ab42' ;; \
		x86) natsArch='386'; sha256='6cf6d8762784832b6a897ad185db66d7282a78e4ab3091bcef27df8ed2651dc0' ;; \
		s390x) natsArch='s390x'; sha256='b03cbd5f725b19da29037947cdd736a31282bbcad214d1c0bee6115193141043' ;; \
		ppc64le) natsArch='ppc64le'; sha256='35dc8889b1c48abcf100a61d022341b70a0225ec72893a46571dbd3218b703b5' ;; \
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
