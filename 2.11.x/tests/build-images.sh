#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.11.0-preview.1)

(
	cd "../alpine3.19"
	docker build --tag nats:${ver[1]}-alpine3.19 .
)

(
	cd "../scratch"
	docker build --tag nats:${ver[1]}-scratch .
)
