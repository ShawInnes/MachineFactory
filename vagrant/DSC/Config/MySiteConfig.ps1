param (
    [string]$nodeName = "localhost",
    [string]$mofFolder = "C:\tmp\MOF\"
)

if (Test-Path($mofFolder)) {
    Remove-Item $mofFolder -Recurse -Force
}

New-Item -ItemType directory -Path $mofFolder | Out-Null

Set-Location $mofFolder | Out-Null

Configuration MySite {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $NodeName
    )

    Node $NodeName
    {
        WindowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }
    }
}

MySite -NodeName $nodeName
