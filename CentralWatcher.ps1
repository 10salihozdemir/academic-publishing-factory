$Root = "E:\GoogleDrive\Articles"
$Projects = Get-ChildItem -Path $Root -Directory

foreach ($Project in $Projects) {
    $ProjectPath = Join-Path $Root $Project.Name
    $LogFile = Join-Path $ProjectPath "sync.log"
    $ErrorFile = Join-Path $ProjectPath "error.log"

    Write-Output "===== PROJECT: $($Project.Name) ====="

    if (Test-Path $LogFile) {
        $LastLog = Get-Content $LogFile -Tail 5
        Write-Output "Last Log:"
        Write-Output $LastLog
    } else {
        Write-Output "No sync log found."
    }

    if (Test-Path $ErrorFile) {
        $LastError = Get-Content $ErrorFile -Tail 3
        Write-Output "Last Error:"
        Write-Output $LastError
    } else {
        Write-Output "No error log found."
    }

    Write-Output "-----------------------------------"
}
