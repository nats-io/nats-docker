FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='22619d91439d95bbc81c41ca4df742bf01202b55cd61394d2ef485dc7c5abcec' ;; \
		armhf) natsArch='arm6'; sha256='e3f20ca2dc05127334a824e22dc191252d84d7ea1f52b77f4d6a7d87b6984fd6' ;; \
		armv7) natsArch='arm7'; sha256='f0244033d5897b83493c2595335e20e8804eae05f9fddd260c3d9b1bbb3bed15' ;; \
		x86_64) natsArch='amd64'; sha256='1bb97e6cd99c65996b2b1a6733410cb17353786232518439c47d91686d638408' ;; \
		x86) natsArch='386'; sha256='735624ae8e6fd557760ba9f4952b0911ffa5b55f0783519ea602406ed8cf20aa' ;; \
		s390x) natsArch='s390x'; sha256='a54f7ce368529a0b5d5b2ac160b91d3a6794ee52a1551e37d88209afd6e86ced' ;; \
		ppc64le) natsArch='ppc64le'; sha256='1ad4da73d20576251d2eabf4b604ac741468a3952d8842b5583f9db051bec7e7' ;; \
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
