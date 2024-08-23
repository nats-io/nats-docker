FROM alpine:3.20

ENV NATS_SERVER 2.10.19-RC.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='9b85adf50c44d9eb19bda258b8dd744cde3736b0a405cbba3b6028801eeaaf97' ;; \
		armhf) natsArch='arm6'; sha256='90b25e2c96b24124375c10a3c95ba39fc6345571df1086b05682bbfdc115303c' ;; \
		armv7) natsArch='arm7'; sha256='eefc2e6a9f98fcf4bd2d5254da6c54809ee428020078ebe06f95264b826464bf' ;; \
		x86_64) natsArch='amd64'; sha256='c14c69497c0e924f8d094d3defa8a09d5346fcbe48f7553ee10c42c82a2637e6' ;; \
		x86) natsArch='386'; sha256='2566474dcb52a73cd11d4ecb30646dfcc9bae508b372bc68b8742f0b20dc0b34' ;; \
		s390x) natsArch='s390x'; sha256='2a268ab801f04a5cdd822fedf32175303f4f80a232e9cbb5f491609de3e4dd1c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='b1aa7bacd9bd1962de1050b0b7562e9acbcff19686352f6ea7e49fdbb57cd866' ;; \
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
