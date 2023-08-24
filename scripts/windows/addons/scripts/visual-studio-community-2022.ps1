Write-Host "Installing Visual Studio Community 2022..."
$installationName=  "Visual Studio Community 2022"
choco install vswhere -y
Write-Host "Refreshing the environment path..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Write-Host "Downloading Visual Studio Community 2022 Setup..."
curl https://aka.ms/vs/17/release/vs_Community.exe -o c:/parallels-tools/vs_community_2022.exe
Write-Host "Installing Visual Studio Community 2022..."
cd c:/parallels-tools
.\vs_community_2022.exe --wait --includeRecommended --add Microsoft.VisualStudio.Workload.CoreEditor --add Microsoft.VisualStudio.Workload.Universal --add Microsoft.VisualStudio.Workload.NativeCrossPlat --quiet

$attempts= 0
while ($true) {
  $attempts++
  $stdout= Invoke-Expression "vswhere -all -format json" | ConvertFrom-Json
  Write-Host "Waiting for installation '$($installationName)' to complete... Attempt: $attempts of 120"
  $found=$false
  foreach ($object in $stdout) {
    if ($object.isComplete) {
      if ($object.displayName -eq $installationName) {
        Write-Host "Installation '$($object.displayName)' is complete."
        $found=$true
        break
      }
    } else {
      Write-Host "Installation '$($object.displayName)' is not complete., waiting"
    }
  }
  if($found) {
    break
  }
      if ($attempts -gt 120) {
      Write-Host "Installation '$($installationName)' is not complete after 1 hour. Exiting..."
      exit 1
    }
    Start-Sleep -Seconds 30
}