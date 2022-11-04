#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.9.6)

(
	cd "${ver[1]}/alpine3.16"
	docker build --tag nats:2.9.6-alpine3.16 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.9.6-scratch .
)
