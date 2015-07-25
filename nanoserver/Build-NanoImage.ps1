. .\NanoServer.ps1

New-NanoServerImage  `
  -MediaPath D:\ ` ### Mount the ISO for Server 2016 Here (Must contain NanoServer folder)
  -BasePath .\Base `
  -TargetPath .\FirstSteps `
  -ComputerName FirstStepsNano `
  -GuestDrivers `
  -EnableIPDisplayOnBoot 

