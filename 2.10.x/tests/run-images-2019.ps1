# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = "NATS_SERVER 2.10.23-RC.12".Split(" ")[1]

$images = @(
	"nats:${ver}-windowsservercore-1809",
	"nats:${ver}-nanoserver-1809"
)

foreach ($img in $images) {
	Write-Output "running ${img}"
	$runId = & docker run --detach "${img}"
	sleep 1

	Write-Output "checking ${img}"
	docker ps --filter "id=${runId}" --filter "status=running" --quiet
	if ($LASTEXITCODE -ne 0) {
		exit 1
	}
	docker kill $runId
}
