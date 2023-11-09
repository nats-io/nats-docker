#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.10.5)

(
	cd "2.9.x/alpine3.18"
	docker build --tag nats:${ver[1]}-alpine3.18 .
)

(
	cd "2.9.x/scratch"
	docker build --tag nats:${ver[1]}-scratch .
)

ver=(NATS_SERVER 2.10.5)

(
	cd "2.10.x/alpine3.18"
	docker build --tag nats:${ver[1]}-alpine3.18 .
)

(
	cd "2.10.x/scratch"
	docker build --tag nats:${ver[1]}-scratch .
)
