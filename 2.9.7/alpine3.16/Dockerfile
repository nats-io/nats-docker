FROM alpine:3.16

ENV NATS_SERVER 2.9.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='153018a675b0e896ffbed0cbc3fe5f733fd674d2f4bf554130ae8960a6c5277c' ;; \
		armhf) natsArch='arm6'; sha256='9714af72c37f0ede4465a3b0324230af74701e82414194a9c2228e7563327523' ;; \
		armv7) natsArch='arm7'; sha256='804ec4f600418d4afd6a9cb94b92c306ab75c589fc5180a5c2c99cc514c0899a' ;; \
		x86_64) natsArch='amd64'; sha256='d4d2ef2952a9a841ce6594a4dbd07b8a45ceea32dadb321ddebc0c56598c2085' ;; \
		x86) natsArch='386'; sha256='add5a328af2cab82230f881f71f7ca4dd907b477972d14a06b77b83188863d4d' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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
