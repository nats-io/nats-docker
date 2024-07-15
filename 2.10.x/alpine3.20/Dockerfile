FROM alpine:3.20

ENV NATS_SERVER 2.10.18-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='7ac80510c3f883bd73025d01004433f8beab88a98866b1a12eb5bb592860c390' ;; \
		armhf) natsArch='arm6'; sha256='2d1f06c486d6e696f9992e3cf035ebc5037a3acf851891d60365b0a1d834ce02' ;; \
		armv7) natsArch='arm7'; sha256='95b1186b96ffa34f47487858c8b75aabd9d6e287dce7d6465f8da991e809fc89' ;; \
		x86_64) natsArch='amd64'; sha256='d373ed00c8a96e3a1bd356be3bf1b862a8036f00caa162808eeef8e4698bc6f8' ;; \
		x86) natsArch='386'; sha256='e2e147fa92fd6a1fcfd1700cc10d673dd9ad953249539e230c7e743f943c9014' ;; \
		s390x) natsArch='s390x'; sha256='83185bad6ea5749db0b5971310f1efb376f9a63639beff1dac2edf1570aae3ee' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f94e47706983e5fe6b9ec1b790b0acc07926ac5852687644ae8b51447617a4e5' ;; \
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
