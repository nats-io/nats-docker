FROM alpine:3.21

ENV NATS_SERVER 2.11.4-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='272f9828fb64c21afff2f88e6133789fb3b98d294827a3a017b7c4ad7a4a54ae' ;; \
		armhf) natsArch='arm6'; sha256='6b2fc32de2a9c55b5f261550785524fec6bb235497905daae193b6321174b1cc' ;; \
		armv7) natsArch='arm7'; sha256='a5bf956aaca884f827f03d1bc4118a90085a08e64a65fd69a97bd61767a261de' ;; \
		x86_64) natsArch='amd64'; sha256='0d936c433b7df3a95f1308d71ac700768956cf56d0adb02532f6c7c9f3b45a62' ;; \
		x86) natsArch='386'; sha256='cbe274d9284bdedf70691e4bd5b9d1b190c18c9afdd0d54f8edc1185d8c05d14' ;; \
		s390x) natsArch='s390x'; sha256='49b68d66ba957283d9d5ec4ff7f776fce6d36993924e46396683b991b580d45e' ;; \
		ppc64le) natsArch='ppc64le'; sha256='bcda710d369e69e03c67c5af8f8948136196368bba9761acfcda68e758b91e7e' ;; \
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
