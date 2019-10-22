#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.1.0)

(
	cd "${ver[1]}/alpine3.10"
	docker build --tag nats:2.1.0-alpine3.10 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.1.0-scratch .
)
