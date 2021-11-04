#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.6.4)

(
	cd "${ver[1]}/alpine3.14"
	docker build --tag nats:2.6.4-alpine3.14 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.6.4-scratch .
)
