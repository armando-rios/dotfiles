# powershell startup parameters

# oh-my-posh prompt call
oh-my-posh init pwsh --config ~/.dotifles/common/ohmyposh/r105.omp.json | Invoke-Expression

# Terminal icons import
Import-Module Terminal-Icons

# Aliases
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig "C:\Program Files\Git\usr\bin\tig.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"

function dev {
    param (
        [string]$project = ""
    )
    $workDir = "D:\Dev"
    if($project -ne "") {
        $targetDir = Join-Path $workDir $project
    } else {
        $targetDir = $workDir
    }
    if(Test-Path $targetDir) {
        Set-Location $targetDir
    } else {
        Write-Host "El proyecto '$project' no existe en '$workDir'" - ForegroundColor Red
    }
}
