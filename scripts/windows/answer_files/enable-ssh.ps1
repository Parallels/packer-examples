Write-Host "Waiting for other commands to be ready before continuing..."
$commands = @("winget")

foreach ($command in $commands) {
  while($true) {
    if(Get-Command $command -ErrorAction SilentlyContinue) {
      Write-Host "$command is available!"
      break
    }
    else {
      Write-Host "$command is not available yet. Sleeping for 5 seconds..."
      Start-Sleep -Seconds 5
    }
  }
}

Add-WindowsCapability -Online -Name "OpenSSH.Client~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "OpenSSH.Server~~~~0.0.1.0"
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22