function Get-TargetResource
{
    [OutputType([Hashtable])]
    param (
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApiKey,
        [string]$OctopusServerUrl,
        [string]$IPAddress,
        [string[]]$Environments,
        [string[]]$Roles,
        [string]$DefaultApplicationDirectory,
        [int]$ListenPort
    )

    Write-Verbose "Checking if Tentacle is installed"
    $installLocation = (get-itemproperty -path "HKLM:\Software\Octopus\Tentacle" -ErrorAction SilentlyContinue).InstallLocation
    $present = ($installLocation -ne $null)
    Write-Verbose "Tentacle present: $present"

    $currentEnsure = if ($present) { "Present" } else { "Absent" }

    $serviceName = (Get-TentacleServiceName $Name)
    Write-Verbose "Checking for Windows Service: $serviceName"
    $serviceInstance = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    $currentState = "Stopped"
    if ($serviceInstance -ne $null)
    {
        Write-Verbose "Windows service: $($serviceInstance.Status)"
        if ($serviceInstance.Status -eq "Running")
        {
            $currentState = "Started"
        }

        if ($currentEnsure -eq "Absent")
        {
            Write-Verbose "Since the Windows Service is still installed, the service is present"
            $currentEnsure = "Present"
        }
    }
    else
    {
        Write-Verbose "Windows service: Not installed"
        $currentEnsure = "Absent"
    }

    return @{
        Name = $Name;
        Ensure = $currentEnsure;
        State = $currentState;
    };
}

function Set-TargetResource
{
    param (
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApiKey,
        [string]$OctopusServerUrl,
        [string]$IPAddress,
        [string[]]$Environments,
        [string[]]$Roles,
        [string]$DefaultApplicationDirectory = "$($env:SystemDrive)\Applications",
        [int]$ListenPort = 10933
    )

    if ($Ensure -eq "Absent" -and $State -eq "Started")
    {
        throw "Invalid configuration: service cannot be both 'Absent' and 'Started'"
    }

    $currentResource = (Get-TargetResource -Name $Name)

    Write-Verbose "Configuring Tentacle..."

    if ($State -eq "Stopped" -and $currentResource["State"] -eq "Started")
    {
        $serviceName = (Get-TentacleServiceName $Name)
        Write-Verbose "Stopping $serviceName"
        Stop-Service -Name $serviceName -Force
    }

    if ($Ensure -eq "Absent" -and $currentResource["Ensure"] -eq "Present")
    {
        Remove-TentacleRegistration -name $Name -apiKey $ApiKey -octopusServerUrl $OctopusServerUrl
    }
    elseif ($Ensure -eq "Present" -and $currentResource["Ensure"] -eq "Absent")
    {
        Write-Verbose "Installing Tentacle..."
        New-Tentacle -name $Name -apiKey $ApiKey -octopusServerUrl $OctopusServerUrl -ipAddress $IPAddress -port $ListenPort -environments $Environments -roles $Roles -DefaultApplicationDirectory $DefaultApplicationDirectory
        Write-Verbose "Tentacle installed!"
    }

    if ($State -eq "Started" -and $currentResource["State"] -eq "Stopped")
    {
        $serviceName = (Get-TentacleServiceName $Name)
        Write-Verbose "Starting $serviceName"
        Start-Service -Name $serviceName
    }

    Write-Verbose "Finished"
}

function Test-TargetResource
{
    param (
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApiKey,
        [string]$OctopusServerUrl,
        [string]$IPAddress,
        [string[]]$Environments,
        [string[]]$Roles,
        [string]$DefaultApplicationDirectory,
        [int]$ListenPort
    )

    $currentResource = (Get-TargetResource -Name $Name)

    $ensureMatch = $currentResource["Ensure"] -eq $Ensure
    Write-Verbose "Ensure: $($currentResource["Ensure"]) vs. $Ensure = $ensureMatch"
    if (!$ensureMatch)
    {
        return $false
    }

    $stateMatch = $currentResource["State"] -eq $State
    Write-Verbose "State: $($currentResource["State"]) vs. $State = $stateMatch"
    if (!$stateMatch)
    {
        return $false
    }

    return $true
}

function Get-TentacleServiceName
{
    param ( [string]$instanceName )

    if ($instanceName -eq "Tentacle")
    {
        return "OctopusDeploy Tentacle"
    }
    else
    {
        return "OctopusDeploy Tentacle: $instanceName"
    }
}

function Invoke-AndAssert {
    param ($block)

    & $block | Write-Verbose
    if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne $null)
    {
        throw "Command returned exit code $LASTEXITCODE"
    }
}

function New-Tentacle
{
    param (
        [Parameter(Mandatory=$True)]
        [string]$name,
        [Parameter(Mandatory=$True)]
        [string]$apiKey,
        [Parameter(Mandatory=$True)]
        [string]$octopusServerUrl,
        [Parameter(Mandatory=$True)]
        [string]$ipAddress,
        [Parameter(Mandatory=$True)]
        [string[]]$environments,
        [Parameter(Mandatory=$True)]
        [string[]]$roles,
        [int] $port,
        [string]$DefaultApplicationDirectory
    )

    if ($port -eq 0)
    {
        $port = 10933
    }

    Write-Verbose "Configuring and registering Tentacle"

    pushd "${env:ProgramFiles}\Octopus Deploy\Tentacle"

    $tentacleHomeDirectory = "$($env:SystemDrive)\Octopus"
    $tentacleAppDirectory = $DefaultApplicationDirectory
    $tentacleConfigFile = "$($env:SystemDrive)\Octopus\$Name\Tentacle.config"
    Invoke-AndAssert { & .\tentacle.exe create-instance --instance $name --config $tentacleConfigFile --console }
    Invoke-AndAssert { & .\tentacle.exe configure --instance $name --home $tentacleHomeDirectory --console }
    Invoke-AndAssert { & .\tentacle.exe configure --instance $name --app $tentacleAppDirectory --console }
    Invoke-AndAssert { & .\tentacle.exe configure --instance $name --port $port --console }
    Invoke-AndAssert { & .\tentacle.exe new-certificate --instance $name --console }
    Invoke-AndAssert { & .\tentacle.exe service --install --instance $name --console }

    $registerArguments = @("register-with", "--instance", $name, "--server", $octopusServerUrl, "--name", $env:COMPUTERNAME, "--publicHostName", $ipAddress, "--apiKey", $apiKey, "--comms-style", "TentaclePassive", "--force", "--console")

    foreach ($environment in $environments)
    {
        foreach ($e2 in $environment.Split(','))
        {
            $registerArguments += "--environment"
            $registerArguments += $e2.Trim()
        }
    }
    foreach ($role in $roles)
    {
        foreach ($r2 in $role.Split(','))
        {
            $registerArguments += "--role"
            $registerArguments += $r2.Trim()
        }
    }

    Write-Verbose "Registering with arguments: $registerArguments"
    Invoke-AndAssert { & .\tentacle.exe ($registerArguments) }

    popd
    Write-Verbose "Tentacle commands complete"
}

function Remove-TentacleRegistration
{
    param (
        [Parameter(Mandatory=$True)]
        [string]$name,
        [Parameter(Mandatory=$True)]
        [string]$apiKey,
        [Parameter(Mandatory=$True)]
        [string]$octopusServerUrl
    )

    $tentacleDir = "${env:ProgramFiles}\Octopus Deploy\Tentacle"
    if ((test-path $tentacleDir) -and (test-path "$tentacleDir\tentacle.exe"))
    {
        Write-Verbose "Beginning Tentacle deregistration"
        Write-Verbose "Tentacle commands complete"
        pushd $tentacleDir
        Invoke-AndAssert { & .\tentacle.exe deregister-from --instance "$name" --server $octopusServerUrl --apiKey $apiKey --console }
        popd
    }
    else
    {
        Write-Verbose "Could not find Tentacle.exe"
    }
}
