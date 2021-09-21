FROM alpine:3.14

ENV NATS_SERVER 2.6.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='1518e0538b62b620c95b2b24da650b0997a911c244884135436d419f18ebee5a' ;; \
		armhf) natsArch='arm6'; sha256='9800707e517cbfcc5aa4d00a0aea3026a504199160755896ae62564435acc539' ;; \
		armv7) natsArch='arm7'; sha256='e61087a29c2a329f71d818e8e64efcc48e05ff79fedfba0e7e4a51f19ea39e08' ;; \
		x86_64) natsArch='amd64'; sha256='61caa7c475fbb2fe5e741b1efa9b3e575f78982d4f74a3f3f75af9a2413bd88f' ;; \
		x86) natsArch='386'; sha256='2e936537a8ea3fe634ad90791facd846bf52a1eed0af9d4559192560ac7829da' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
