function Disable-AutomaticallyDetectProxySettings
{
    # Read connection settings from Internet Explorer.
    $regKeyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\"
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
 
    # Index into DefaultConnectionSettings where the relevant flag resides.
    $flagIndex = 8
 
    # Bit inside the relevant flag which indicates whether or not to enable automatically detect proxy settings.
    $autoProxyFlag = 8
 
    if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
    {
        # 'Automatically detect proxy settings' was enabled, adding one disables it.
        Write-Host "Disabling 'Automatically detect proxy settings'."
        $mask = -bnot $autoProxyFlag
        $conSet[$flagIndex] = $conSet[$flagIndex] -band $mask
        $conSet[4]++
        Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
    }
    
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
    if ($($conSet[$flagIndex] -band $autoProxyFlag) -ne $autoProxyFlag)
    {
    	Write-Host "'Automatically detect proxy settings' is disabled."
    }
}

$job = Start-Job -ScriptBlock { Start-Process "C:\Program Files\Internet Explorer\iexplore.exe" -Wait -PassThru }
Start-Sleep -Seconds 5
Stop-Job -Id $job.Id

Disable-AutomaticallyDetectProxySettings

Set-Itemproperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" -Name ProxyEnable -Value 0

Restart-Computer -Force
