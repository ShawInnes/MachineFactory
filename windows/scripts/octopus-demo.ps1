
choco install git.install
choco install nuget.commandline

New-Item -Path C:\Build -ItemType Directory
Set-Location -Path C:\Build

git clone https://github.com/OctopusDeploy/Octopus-Samples

nuget restore Octopus-Samples\Source\Samples.sln

msbuild Octopus-Samples\Source\Samples.sln /p:VisualStudioVersion=10.0 /p:RunOctoPack=True /p:OctoPackPublishPackageToHttp=http://10.0.1.76/nuget/packages /p:OctoPackPublishApiKey=API-Z6K6W9AQAIKAHX1OOLSVIQOPW
