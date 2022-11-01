#!/usr/bin/env bash
set -ex

images=(
	'nats:2.9.5-alpine3.16'
	'nats:2.9.5-scratch'
)

for img in "${images[@]}"; do
	run_id=$(docker run --detach "${img}")
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done
