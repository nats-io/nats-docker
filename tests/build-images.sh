#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.5.0)

(
	cd "${ver[1]}/alpine3.14"
	docker build --tag nats:2.5.0-alpine3.14 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.5.0-scratch .
)
