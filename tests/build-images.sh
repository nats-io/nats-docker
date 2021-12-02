#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.6.6)

(
	cd "${ver[1]}/alpine3.14"
	docker build --tag nats:2.6.6-alpine3.14 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.6.6-scratch .
)
