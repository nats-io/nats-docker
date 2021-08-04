#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.3.4)

(
	cd "${ver[1]}/alpine3.14"
	docker build --tag nats:2.3.4-alpine3.14 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.3.4-scratch .
)
