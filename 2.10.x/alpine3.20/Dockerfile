FROM alpine:3.20

ENV NATS_SERVER 2.10.21-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='0fb25e49dd566a3553721430ee2f2741e15082e9a867d1e7b34f0868391452b2' ;; \
		armhf) natsArch='arm6'; sha256='d205ae6cff7f2f984734a4b5ecf20d39f752dae11b91780194de40a27790d4f2' ;; \
		armv7) natsArch='arm7'; sha256='5c6c3921d07a5ae61faa9d530bed3369049864b043303d63a5ada46540f85fa5' ;; \
		x86_64) natsArch='amd64'; sha256='9334b40c207a0f9b357b9ba447dfcc64f99d8ed9b2877c9855ce6c3fd5ec27de' ;; \
		x86) natsArch='386'; sha256='1ae7f0bd9e3c07e46b73123dc6785ef530ac6e149ac3ceafedc16e687dcc4926' ;; \
		s390x) natsArch='s390x'; sha256='9d4976149eb86873af85e4b4a42e542ae22a938696433db12c95e1a2996ac97d' ;; \
		ppc64le) natsArch='ppc64le'; sha256='cdd0e586ecf282ad82c921f98a7bea720c6c929733961bae65db4d27cd89b515' ;; \
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
