# get latest download url
$logFile = "C:\winget\winget-install.log"
New-Item -ItemType Directory -Force -Path "c:\winget"
Write-Host "Installing the Winget CLI..."
$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
  Select-Object -ExpandProperty "assets" |
  Where-Object "browser_download_url" -Match '.msixbundle' |
  Select-Object -ExpandProperty "browser_download_url"

# VC libs url
$VCLibsUrl = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
$UIXmlUrl = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3"

# Download dependencies

# Download and install VCLibs
Write-Host "Installing the VCLibs..."
Invoke-WebRequest -Uri $VCLibsUrl -OutFile "c:\winget\Microsoft.VCLibs.arm64.14.00.Desktop.appx" -UseBasicParsing
Add-AppxPackage -Path "c:\winget\Microsoft.VCLibs.arm64.14.00.Desktop.appx"

# Download and install UIXml
Write-Host "Installing the UIXml..."
Invoke-WebRequest -Uri $UIXmlUrl -OutFile "c:\winget\Microsoft.UI.Xaml.2.7.3.zip" -UseBasicParsing
Expand-Archive -Path "c:\winget\Microsoft.UI.Xaml.2.7.3.zip" -DestinationPath "c:\winget\Microsoft.UI.Xaml.2.7.3"
Add-AppxPackage -Path "c:\winget\Microsoft.UI.Xaml.2.7.3\tools\AppX\arm64\Release\Microsoft.UI.Xaml.2.7.appx"


# download
Write-Host "Downloading the Winget CLI..."
Invoke-WebRequest -Uri $URL -OutFile "c:\winget\Setup.msix" -UseBasicParsing

# Install
Write-Host "Installing the Winget CLI..."
Add-AppxPackage -Path "c:\winget\Setup.msix"


# delete file
Write-Host "Cleaning up..."
Remove-Item "c:\winget" -Recurse

