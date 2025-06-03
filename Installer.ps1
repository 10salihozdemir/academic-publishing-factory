function Install-AcademicProject {
    param (
        [string]$ProjectName,
        [string]$RemoteURL
    )

    $Root = "E:\GoogleDrive\Articles"
    $Path = "$Root\$ProjectName"
    $BibFile = "$ProjectName.bib"

    if (!(Test-Path $Path)) { New-Item -ItemType Directory -Path $Path }
    if (!(Test-Path "$Path\$BibFile")) { New-Item -ItemType File -Path "$Path\$BibFile" }

    cd $Path
    git init
    git add $BibFile
    git commit -m "Initial commit"
    git remote add origin $RemoteURL

    try { git pull origin master --allow-unrelated-histories } catch {}
    git push -u origin master

    $Script = @"
\$Path = "$Path"
\$BibFile = "$ProjectName.bib"
\$LogFile = "\$Path\sync.log"
\$ErrorFile = "\$Path\error.log"

while (\$true) {
    try {
        cd \$Path
        git pull origin master | Out-File -Append \$LogFile
        git add \$BibFile
        \$status = git status --porcelain
        if (\$status) {
            git commit -m "Auto update" | Out-File -Append \$LogFile
            \$retryCount = 0
            :RetryLoop
            try {
                git push origin master | Out-File -Append \$LogFile
            } catch {
                \$retryCount++
                if (\$retryCount -le 5) {
                    Start-Sleep -Seconds 10
                    goto RetryLoop
                } else {
                    throw \$_
                }
            }
        }
    } catch {
        ("[" + (Get-Date) + "] " + \$_ .Exception.Message) | Out-File -Append \$ErrorFile
    }
    Start-Sleep -Seconds 300
}
"@

    $ScriptPath = "$Path\AutoPush.ps1"
    $Script | Set-Content $ScriptPath

    $ServiceName = "${ProjectName}Sync"
    & 'C:\Program Files\nssm\nssm.exe' install $ServiceName powershell.exe "-ExecutionPolicy Bypass -File `"$ScriptPath`""
    & 'C:\Program Files\nssm\nssm.exe' start $ServiceName
}
