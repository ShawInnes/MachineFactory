
(New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name WindowsUpdate) | Out-Null
(New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -Name AU) | Out-Null
(New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name NoAutoUpdate -Value 1) | Out-Null
