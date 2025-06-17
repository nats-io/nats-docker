FROM alpine:3.22

ENV NATS_SERVER 2.11.5-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='47a7b255ff0026bee646c0baeb2cf324f817caba6e612c07fe52d85e45cb75df' ;; \
		armhf) natsArch='arm6'; sha256='606c45060815aecafb2459538e370dc5acff290f6172bdefaa0985cb0eb29b9b' ;; \
		armv7) natsArch='arm7'; sha256='f6c2fc5d91be1ab86c9db79f94e96b5c69dd67faa71aaf514ed9398c9d51e2a9' ;; \
		x86_64) natsArch='amd64'; sha256='69f7a1a8f70d52cc4265bf7121ebc527b0689ba71d23d9ab42a487e12102da12' ;; \
		x86) natsArch='386'; sha256='70afe8d83445a0006212c270a10b27aad40694cc4cac1d6c6bdff6d3fbb94080' ;; \
		s390x) natsArch='s390x'; sha256='679a2e5f76f69f68563449915a30dbf7b73ca60c645345a827a7c0df3dbaf613' ;; \
		ppc64le) natsArch='ppc64le'; sha256='3c077facdcc04599fad96d4b9a6d55769bf6b04991132000ecf773ecb3749fee' ;; \
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
