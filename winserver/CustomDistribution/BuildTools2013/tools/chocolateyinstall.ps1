#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = 'Stop';


$packageName = 'BuildTools2015' # arbitrary name for the package, used in messages
$registryUninstallerKeyName = 'BuildTools2015' #ensure this is the value in the registry
$installerType = 'EXE' #only one of these: exe, msi, msu
$url = 'C:\Install\BuildTools_2013_Full.exe' # download url
$url64 = '' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/silent' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# main helper functions - these have error handling tucked into them already
# see https://github.com/chocolatey/choco/wiki/HelpersReference
# Install an application, will assert administrative rights
# add additional optional arguments as necessary
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"

Install-ChocolateyPath 'C:\Program Files (x86)\MSBuild\13.0\Bin' 'Machine' # Machine will assert administrative rights

