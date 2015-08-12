
(New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name WindowsUpdate -Force) | Out-Null
(New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -Name AU -Force) | Out-Null
(New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name NoAutoUpdate -Value 1 -Force) | Out-Null
