Write-Output "Installing WMF5 (Powershell)"

choco install powershell --pre

Write-Output "Done"

Restart-Computer -Force
