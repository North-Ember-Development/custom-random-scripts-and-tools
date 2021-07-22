#function Run-Elevated ($scriptblock)
#{
#  # TODO: make -NoExit a parameter
#  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
#  $sh = new-object -com 'Shell.Application'
#  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
#}

# If WSL not running, stuck or something, try to run this script to prevent wsl stucking.

Write-Host "Trying to fix wsl."

Start-Process Powershell -Verb runAs ("Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Microsoft-Windows-Subsystem-Linux; " +
    "dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all")
    