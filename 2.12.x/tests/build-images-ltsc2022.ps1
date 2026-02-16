# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = 'NATS_SERVER 2.12.5-RC.1'.Split(' ')[1]

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

# The windowsservercore images must be built before the nanoserver images.
cd "../windowsservercore-ltsc2022"
Write-Host "building windowsservercore-ltsc2022"
docker build --tag "nats:${ver}-windowsservercore-ltsc2022" .
if ($LASTEXITCODE -ne 0) {
    exit 1
}

cd "../nanoserver-ltsc2022"
Write-Host "building nanoserver-ltsc2022"
docker build --tag "nats:${ver}-nanoserver-ltsc2022" .
if ($LASTEXITCODE -ne 0) {
    exit 1
}

docker images
