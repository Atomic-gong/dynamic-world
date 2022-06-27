if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

Set-ExecutionPolicy Bypass -Scope Process -Force;
$InstallDir='C:\ProgramData\chocoportable'
$env:ChocolateyInstall="$InstallDir"
Set-ExecutionPolicy Bypass -Scope Process -Force;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco upgrade chocolatey -y
choco install git -y
cmd.exe /c git clone https://github.com/atomic-gong/dynamic-world.git

Copy-Item -Path ".\dynamic-world\mods\*" -Destination ($env:APPDATA + "\.minecraft\mods") -Recurse
Remove-Item -Recurse -Force ".\dynamic-world"