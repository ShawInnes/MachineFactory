Write-Output "Configuring Chocolatey to use Vagrant Cache"

$configContent = Get-Content ${env:ProgramData}\\Chocolatey\\config\\chocolatey.config | ForEach-Object { $_ -replace "<cacheLocation />", "<cacheLocation>\\vagrant</cacheLocation>" }

Set-Content ${env:ProgramData}\\Chocolatey\\config\\chocolatey.config -Value $configContent

Write-Output "Done."
