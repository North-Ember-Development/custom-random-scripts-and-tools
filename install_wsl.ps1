function Run-Elevated ($scriptblock)
{
  # TODO: make -NoExit a parameter
  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
  $sh = new-object -com 'Shell.Application'
  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
}

$script =
@"
Write-Host "Enabling Hyper-V"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
bcdedit /set hypervisorlaunchtype auto

Write-Host "ENABLING LINUX SUBSYSTEM"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

Write-Host "ENABLING VIRTUAL PLATFORM HOST"
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "ENABLING OPTIONAL FETURES."
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

Write-Host "CONFIGURING WSL OPTIONS."
wsl --set-default-version 2
wsl.exe --install --distribution Ubuntu
wsl.exe --set-version Ubuntu 2
Restart-Computer
"@

Run-Elevated "$script" 
