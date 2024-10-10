FROM alpine:3.20

ENV NATS_SERVER 2.10.22-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='8eeb28c90d5db0a36b87053ff45c2b2e8719e79914a66d805dbef6ea62570c9b' ;; \
		armhf) natsArch='arm6'; sha256='4a89a0238aa4e40c021c4a153e46b641766674ca6e22a941c1cf7d1957056dd4' ;; \
		armv7) natsArch='arm7'; sha256='25b694fac489d9fb7132ef3239e1b636f13d8150f530525c1ab593ff68930c92' ;; \
		x86_64) natsArch='amd64'; sha256='546828c999809d9162a59aae431c519cdb165135d01b4085eec73616ef5ebd34' ;; \
		x86) natsArch='386'; sha256='140d736224776db483d69f9f5a6d6421efb91332b095e44143c14d5677da362a' ;; \
		s390x) natsArch='s390x'; sha256='552f5691c0cb97a2544e15497d4998b0e93b911bb7fe8b95a9c96aaebe29d9e7' ;; \
		ppc64le) natsArch='ppc64le'; sha256='5887523ad908364dac617b1f463654ce5d991ed9cdcde33f6766a492861f7ecb' ;; \
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
