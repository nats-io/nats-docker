# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = "NATS_SERVER 2.12.5-RC.1".Split(" ")[1]

$images = @(
	"nats:${ver}-windowsservercore-ltsc2022",
	"nats:${ver}-nanoserver-ltsc2022"
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
