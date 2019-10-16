#!/usr/bin/env bash
set -ex

images=(
	'nats:2.1.0-scratch'
)

for i in "${images[@]}"; do
	run_id=$(docker run --detach nats:2.1.0-scratch)
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done
