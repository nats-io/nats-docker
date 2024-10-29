FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='aab1db10aaf8cccaeba6ee755b45c0aefad2f2e3b954d7051c349bcf9b652bf8' ;; \
		armhf) natsArch='arm6'; sha256='0603b9bfbd35edeb54e0e5b5f8a1d3cefc34247a5abe6d0c936b6c8fdc9f7544' ;; \
		armv7) natsArch='arm7'; sha256='e5cdd986775aa6df8eb7ead92d1d9bb974c6a921dad3aadaaa58c32e6951a288' ;; \
		x86_64) natsArch='amd64'; sha256='ca888cde1cb05e2d6aba17bba5c0970f6a2b320aeee61ab28cef54298adccc44' ;; \
		x86) natsArch='386'; sha256='36ede3cf3094f0b8f2216b970023624ae556641980652623a35a0967fb787d95' ;; \
		s390x) natsArch='s390x'; sha256='0a53f5d9871dd3d843e1b7bfb9dcdf8039dc04d9c7d549ea18298c2c34a0eec0' ;; \
		ppc64le) natsArch='ppc64le'; sha256='e7ddd7af68ab74c9a2a9059508ef7d9e4fbec3c2c0ed8ad397187e73a4c63ead' ;; \
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
