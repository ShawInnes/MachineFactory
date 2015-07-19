$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exePath = "$scriptPath\SQLEXPRWT_x64_ENU.exe"
$extractPath = "$scriptPath\SQLEXPRWT_x64_ENU"
$setupPath = "$extractPath\setup.exe"

Get-ChocolateyWebFile 'SqlServerExpress2014' "$exePath" "C:\Install\SQLEXPRWT_x64_ENU.exe" -validExitCodes @(0,-2067529716)

Write-Host "Extracting..."
Start-Process "$exePath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
& "$setupPath" /IACCEPTSQLSERVERLICENSETERMS /QS /ACTION=install /INSTANCEID=SQLEXPRESS /INSTANCENAME=SQLEXPRESS /UPDATEENABLED=FALSE

Write-Host "Removing extracted files..."
rm -r "$extractPath"