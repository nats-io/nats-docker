#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.9.10)

(
	cd "${ver[1]}/alpine3.17"
	docker build --tag nats:2.9.10-alpine3.17 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.9.10-scratch .
)
