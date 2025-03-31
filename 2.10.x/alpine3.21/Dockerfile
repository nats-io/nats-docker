FROM alpine:3.21

ENV NATS_SERVER 2.10.27-binary

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='2e6266b075c1f6905d974ead21ea65751125ec1f1c3a551152019755e5218c84' ;; \
		armhf) natsArch='arm6'; sha256='b4f0613142539cf3260cfa6c7356dbbd3eea3020c5c01259ac7ff0af26809a86' ;; \
		armv7) natsArch='arm7'; sha256='9f92594d9a3b52c2afb9ee107e168a62f1bc84a4f22defcaf8601c0a9c55bde7' ;; \
		x86_64) natsArch='amd64'; sha256='5c9cd216cc0ce78092201a79e75a57607565d6e3aabad50305699dd468d579df' ;; \
		x86) natsArch='386'; sha256='832a8e48a00ddccaef20602d364051d6f25790f0fc366187b1d5979b3c0cd1c9' ;; \
		s390x) natsArch='s390x'; sha256='2562b3eb32a99a00dd8c9b0dfcd05d925cf1a09dd83d72268d2aa87c3f7e243f' ;; \
		ppc64le) natsArch='ppc64le'; sha256='48c7d863e614224268bf98ef47b221ca43d5be00c8ce44870d819ab50ba62f2b' ;; \
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
