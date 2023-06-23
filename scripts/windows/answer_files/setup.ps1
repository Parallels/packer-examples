Write-Host 'Disabling hibernation...'
powercfg /hibernate off

Write-Host 'Setting the power plan to high performance...'
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

#
# reclaim the free disk space.

Write-Host 'Reclaiming the free disk space...'
$results = defrag.exe C: /H /L
if ($results -eq 'The operation completed successfully.')
{
    $results
}
else
{
    if ((Get-CimInstance Win32_OperatingSystem).version -eq "6.3.9600")
    {
        return
    }
    else
    {
        Write-Host 'Zero filling the free disk space...'
        (New-Object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/SDelete.zip', "$env:TEMP\SDelete.zip")
        Expand-Archive "$env:TEMP\SDelete.zip" $env:TEMP
        Remove-Item "$env:TEMP\SDelete.zip"
        &"$env:TEMP\sdelete64.exe" -accepteula -z C:
    }
}