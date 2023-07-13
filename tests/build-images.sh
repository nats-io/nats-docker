#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.9.20)

(
	cd "${ver[1]}/alpine3.18"
	docker build --tag nats:2.9.20-alpine3.18 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.9.20-scratch .
)
