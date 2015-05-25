Get-PackageProvider -Name NuGet -ForceBootstrap

Register-PsRepository -Name PSGallery -SourceLocation http://www.powershellgallery.com/api/v2/
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

