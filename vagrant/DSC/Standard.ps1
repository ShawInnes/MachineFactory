param($nodeName = "localhost", $mofFolder = "/tmp/MOF")

if (Test-Path($mofFolder)) {
    Remove-Item $mofFolder -Recurse -Force
}

New-Item -ItemType directory -Path $mofFolder | Out-Null
Set-Location $mofFolder | Out-Null

Configuration Standard
{
  Import-DscResource -Module xNetworking

  Node "localhost"
  {
    WindowsFeature IIS
    {
        Ensure = "Present"
        Name = "Web-Server"
    }

    WindowsFeature IISManagerFeature
    {
        Ensure = "Present"
        Name = "Web-Mgmt-Tools"
    }    
  }
}

Standard
