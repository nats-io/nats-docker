# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = 'NATS_SERVER 2.1.0'.Split(' ')[1]

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

# The windowsservercore images must be built before the nanoserver images.
cd "${ver}/windowsservercore-1809"
Write-Host "building windowsservercore-1809"
docker build --tag nats:2.1.0-windowsservercore-1809 .
cd ../nanoserver-1809
Write-Host "building nanoserver-1809"
docker build --tag nats:2.1.0-nanoserver-1809 .

# We can't test these images on GitHub CI. We get the following error on both
# windows-2019 and windows-2016.
# 	The container operating system does not match the host operating system.
#
# cd ../windowsservercore-1803
# Write-Host "building windowsservercore-1803"
# docker build --tag nats:2.1.0-windowsservercore-1803 .
# cd ../nanoserver-1803
# Write-Host "building nanoserver-1803"
# docker build --tag nats:2.1.0-nanoserver-1803 .

docker images
