#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.1.2)

(
	cd "${ver[1]}/alpine3.10"
	docker build --tag nats:2.1.2-alpine3.10 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats:2.1.2-scratch .
)
