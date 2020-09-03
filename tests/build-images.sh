#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.1.8)

(
	cd "${ver[1]}/alpine3.11"
	docker build --tag nats:2.1.8-alpine3.11 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.1.8-scratch .
)
