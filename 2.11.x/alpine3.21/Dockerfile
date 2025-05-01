FROM alpine:3.21

ENV NATS_SERVER 2.11.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='24a56aa64219aa6668a18e2d0ea9108d72472852e47677b384c856fc412ae4c7' ;; \
		armhf) natsArch='arm6'; sha256='86fe21d7413b6c7ce68250c0645567b0550eacf2a18eea56374630c83f0f1a76' ;; \
		armv7) natsArch='arm7'; sha256='1832b4f0e105a01b0366ea2e3071aa235870067f0d042db2ff4dfdb6ceb673a8' ;; \
		x86_64) natsArch='amd64'; sha256='9cdab8b2e2488128caee6519e2f15f1aa33a78b4386ee1776a06b4818d7ec197' ;; \
		x86) natsArch='386'; sha256='9173707ded6d71210c5e0eb9a29f3979888a7e658d52cb8fe32b7e498a852143' ;; \
		s390x) natsArch='s390x'; sha256='61de816adafa99fbe7130ee77a350fd44f7c97c51bc28a210e0a53c0ced1621f' ;; \
		ppc64le) natsArch='ppc64le'; sha256='5b1a2ea2bcd68d0751dd718ce434a7c57161415c202e5723191891360b1e5fd7' ;; \
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
