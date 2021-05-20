#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.2.5)

(
	cd "${ver[1]}/alpine3.13"
	docker build --tag nats:2.2.5-alpine3.13 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.2.5-scratch .
)
