FROM alpine:3.20

ENV NATS_SERVER 2.10.19-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='e234e56883453c3c03e4e93734cca1f801b267a8ebad064d2bac9dd855d4bf6e' ;; \
		armhf) natsArch='arm6'; sha256='351480ed227a6e47efbd545a5860a5718558a343c496465e84930350bae79cba' ;; \
		armv7) natsArch='arm7'; sha256='6c7c12b173d9229e6477d4d2581d31dee016de35924d167b9c509d91e7c42ce5' ;; \
		x86_64) natsArch='amd64'; sha256='87c45f12cf8ee6f61f2fd9b5d8f5c8717d573a225c19f2156c66f5521fc5a4bf' ;; \
		x86) natsArch='386'; sha256='2abd25d7194ce66ccbfc34a00542b64dbe86c1d30621602bb7bc85f3c633e803' ;; \
		s390x) natsArch='s390x'; sha256='4b6a434b87dbd5e05cef7ad08cf6fa3729190f0c7a79fbe62f9e4905f9272cfb' ;; \
		ppc64le) natsArch='ppc64le'; sha256='0f1c1c4652b60e2f31a4146b03e257859f4028131e66f50ab4c2407548adfcf7' ;; \
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
