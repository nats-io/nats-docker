# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = 'NATS_SERVER 2.1.7'.Split(' ')[1]

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

cd "${ver}/windowsservercore-ltsc2016"
Write-Host "building windowsservercore-ltsc2016"
docker build --tag nats:2.1.7-windowsservercore-ltsc2016 .

docker images
