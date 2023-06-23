param(
  [Parameter(Mandatory=$true)]
  [string]$ScriptNames
)

$basePath = "c:/parallels-tools/addons/choco"

if ($ScriptNames -eq "*") {
  $scriptNamesArray = Get-ChildItem -Path "$PSScriptRoot/scripts" -Filter *.ps1 | Select-Object -ExpandProperty Name
} else {
  $scriptNamesArray = $ScriptNames.Split(',')
}

foreach ($scriptName in $scriptNamesArray) {
  $scriptPath = "$basePath/scripts/$scriptName.ps1"
  if (Test-Path $scriptPath) {
    Write-Host "Executing script $scriptName"
    & $scriptPath
  } else {
    Write-Warning "Script $scriptName not found in the script folder"
  }
}

exit 0