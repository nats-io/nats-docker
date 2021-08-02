#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.3.3)

(
	cd "${ver[1]}/alpine3.14"
	docker build --tag nats:2.3.3-alpine3.14 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.3.3-scratch .
)
