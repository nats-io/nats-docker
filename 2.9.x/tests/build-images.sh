#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.9.24)

(
	cd "../alpine3.18"
	docker build --tag nats:${ver[1]}-alpine3.18 .
)

(
	cd "../scratch"
	docker build --tag nats:${ver[1]}-scratch .
)
