#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.9.x)

(
	cd "${ver[1]}/alpine3.18"
	docker build --tag nats:${ver[1]}-alpine3.18 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:${ver[1]}-scratch .
)
