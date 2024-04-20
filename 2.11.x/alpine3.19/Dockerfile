FROM alpine:3.19

ENV NATS_SERVER 2.11.0-preview.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='35e4ee3926afbf5101e9f1cb9293135dd8857aff877af0657c6fdf15c5e7bc03' ;; \
		armhf) natsArch='arm6'; sha256='15c097c48be4eff2ce93a5f6af4522bf1af0fd808e8f5286ba592500bbb4afc5' ;; \
		armv7) natsArch='arm7'; sha256='c4ede5af9de834865a56453939622db276381c453b8ba8f282caa4464db22f09' ;; \
		x86_64) natsArch='amd64'; sha256='0d2f358017bb56562d168654be4c5559eca949547f478256088ee3b0fad4078d' ;; \
		x86) natsArch='386'; sha256='05677c0ebcb9d8a54ccbf0d98a637e21da2f2fb44e49991c741cc0f1ccb834c9' ;; \
		s390x) natsArch='s390x'; sha256='2df2f7454cf2961768cb687f9a2fcb3ed165f3b1f9073e38cb34f361606aacff' ;; \
		ppc64le) natsArch='ppc64le'; sha256='80032bd02adaf7c745e812e544bf686490ff95a72ae1e156b0cf445ac9bdaf91' ;; \
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

RUN apk add --no-cache libcap \
  && setcap cap_net_bind_service=+ep /usr/local/bin/nats-server \
  && apk del libcap

EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]
