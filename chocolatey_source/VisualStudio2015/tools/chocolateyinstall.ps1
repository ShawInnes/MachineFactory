#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = 'Stop';

$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')

$packageName = 'VisualStudio2015' # arbitrary name for the package, used in messages
$registryUninstallerKeyName = 'VisualStudio2015' #ensure this is the value in the registry
$installerType = 'EXE' #only one of these: exe, msi, msu
$url = '\\vmware-host\Shared Folders\ISO\en_visual_studio_enterprise_2015_x86_x64_dvd_6850497.iso' # download url

$silentArgs = '/Passive /NoRestart /AdminFile $adminFile' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet

$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Next, mount the ISO file, ready for using it's contents (NOTE: the last parameter here is the drive letter that will be assigned to the mounted ISO)
imdisk -a -f $url -m "w:"

# Run commands against the mounted ISO, in this case, run the setup.exe
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "w:\vs_enterprise.exe"

# Unmount the ISO file when finished
imdisk -d -m w:
