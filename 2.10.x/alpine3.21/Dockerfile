FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='2f15472e56dbdfd1d06c5ebd82f374b846ab30aa4d910e9ae6b8198a8e718fd7' ;; \
		armhf) natsArch='arm6'; sha256='b6377670ef66a064d0c91e4d2dd92b68ad1eb601dd703758ec39eb1269c17abc' ;; \
		armv7) natsArch='arm7'; sha256='e0fb292dce3b28d3045033a077a0c06afdfd85c1818b120ed050b3720b930dbc' ;; \
		x86_64) natsArch='amd64'; sha256='e5db259c975e7f90d28fca34289d64db352002c3b8ef71ac4f981ea5fc1391de' ;; \
		x86) natsArch='386'; sha256='1ce4dcc38f1526bc9668f27c73f9f970f869ec7e7757e152b373db3a57b7fb7d' ;; \
		s390x) natsArch='s390x'; sha256='202e421c617cb41417542b9f1ddbfbb615c0b31b9c8406bb9dbe8aeffba38877' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d8f798a578965c0ea60268a03988b7eaa908d89785133396c0a966bc8e0efc90' ;; \
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
