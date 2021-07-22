#function Run-Elevated ($scriptblock)
#{
#  # TODO: make -NoExit a parameter
#  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
#  $sh = new-object -com 'Shell.Application'
#  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
#}

# If WSL not running, stuck or something, try to run this script to prevent wsl stucking.
# after you've restarted the computer, please, install https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# and run wsl --set-default-version 2
# TODO: Create method to run code after window's reboot , and perform automatic downloading / installing and updating to wsl 2.

Write-Host "Trying to fix wsl."

Start-Process Powershell -Verb runAs ("Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Microsoft-Windows-Subsystem-Linux; " +
    "dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all")
    