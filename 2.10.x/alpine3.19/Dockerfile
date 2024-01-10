FROM alpine:3.19

ENV NATS_SERVER 2.10.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='9a88afab7b3805475ff7250649447d8807dd52262011252e7faedec926d01782' ;; \
		armhf) natsArch='arm6'; sha256='37f8d913cdc69143edf8bd20bceced053b90dba26d1fa94e2e07b6fe17f9db2e' ;; \
		armv7) natsArch='arm7'; sha256='d96042f12ecc0578d193d5353c362a572384c6ad9a46db73b7cb5f28cb6e4ad2' ;; \
		x86_64) natsArch='amd64'; sha256='91f5b493ce3151baa0b15d8bf093279dc94106dd56a201704a20de567607bcf7' ;; \
		x86) natsArch='386'; sha256='a5cddcac9f8debaf45e7b9ba3960778b1c786020c690991094ce31d033ec7649' ;; \
		s390x) natsArch='s390x'; sha256='01138e819d34970c76d621464dc8e8dfce0e05a162b5c36e2a4aed6198c6aba6' ;; \
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
