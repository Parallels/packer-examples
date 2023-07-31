Write-Host "Installing Flutter 3.10.5..."
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.10.5-stable.zip" -OutFile "$env:TEMP\flutter.zip"

# Extract the Flutter SDK to the Program Files directory
Expand-Archive -Path "$env:TEMP\flutter.zip" -DestinationPath "$env:ProgramFiles\Flutter"

# Add the Flutter SDK to the system PATH
$flutterPath = "$env:ProgramFiles\Flutter\bin"
$existingPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($existingPath -notlike "*$flutterPath*") {
  [Environment]::SetEnvironmentVariable("Path", "$existingPath;$flutterPath", "Machine")
}

Write-Host "Installing VSCode..."
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "/scripts/vscode.ps1"
Write-Host "Installing VSCode... Done!"

# Verify the installation
flutter doctor
Write-Host "Installing Flutter 3.10.5... Done!"