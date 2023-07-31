Write-Host "Installing Visual C++ Redistributable 2022..."
winget install --id=Microsoft.VCRedist.2022.arm64 -e --silent --accept-package-agreements --accept-source-agreements
Write-Host "Installing Visual C++ Redistributable 2022... Done!"