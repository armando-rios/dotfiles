$primary = "DarkMagenta"
$secondary = "DarkCyan"
$textWhite = "White"
$textBlack = "Black"
$success = "Green"
$warning = "Yellow"

Clear-Host
# Primer conjunto de mensajes
Write-Host " STARTING ARMANDO-RIOS SETUP SCRIPT... " -ForegroundColor $textBlack -Background $primary

# Esperar 3 segundos
Start-Sleep -Seconds 3

Clear-Host

# Ruta al ejecutable de Git
$gitPath = "C:\Program Files\Git\cmd\git.exe"
$clone = "clone"
$repo = "https://github.com/armando-rios/dotfiles"
$ruteClone = "$env:USERPROFILE\.dotfiles"

function Is-GitInstalled {
    try {
        git --version > $null 2>&1
        return $true
    } catch {
        return $false
    }
}

function Install-Git {
    Write-Host " Gir is not installed. starting installation! " -Foreground $textBlack -Background $warning
    winget install --id Git.Git -e
}


function Show-SelectionMenu {
    param (
        [string[]]$optionList,
        [string]$prompt
    )

    $selectedOptions = @()
    $index = 0
    $maxIndex = $optionList.Length - 1

    Write-Host " RUNNING CONFIGURATION SCRIPT" -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host $prompt -ForegroundColor Blue
    Write-Host " Use the up and down arrow keys to navigate. Press [Space] to select/deselect, and [Enter] to continue. " -ForegroundColor $textBlack -Background $secondary

    while ($true) { 
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT" -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host " Use the up and down arrow keys to navigate. Press [Space] to select/deselect, and [Enter] to continue. " -ForegroundColor $textBlack -Background $secondary

        for ($i = 0; $i -lt $optionList.Length; $i++) {
            if ($i -eq $index) {
                Write-Host "> " -NoNewline -ForegroundColor Yellow
            } else {
                Write-Host "  " -NoNewline
            }

            if ($selectedOptions -contains $optionList[$i]) {
                Write-Host "[X] $($optionList[$i])" -Foreground Green
            } else {
                Write-Host "[ ] $($optionList[$i])"
            }
        }

        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            38 { # Flecha arriba
                $index = if ($index -gt 0) { $index - 1 } else { $maxIndex }
            }
            40 { # Flecha abajo
                $index = if ($index -lt $maxIndex) { $index + 1} else { 0 }
            }
            32 { # Espacio 
                if ($selectedOptions -contains $optionList[$index]) {
                    $selectedOptions = $selectedOptions -ne $optionList[$index]
                } else {
                    $selectedOptions += $optionList[$index]
                }
            }
            13 { # Enter
                return $selectedOptions
            }
        }
    }
}

if (-not (Is-GitInstalled)) {
    Install-Git
    Write-Host " Git has been installed successfully. " -ForegroundColor $textBlack -Background $success
}

function Install-Program {
    param (
        [string]$programName
    )
    winget install --id $programName
}

# Primera seccion: Seleccion de tareas
$tareas = @(
    "Install a new environment",
    "Install programs",
    "Install and customize terminal"
)

$selectedTareas = Show-SelectionMenu -optionList $tareas -prompt "Select the areas you want to perform"

# Si selecciona "Instalacion completa", automaticamente selecciona todas las opciones
if ($selectedTareas -contains "Install a new environment") {
    $selectedTareas = @("Install programs", "Install and customize terminal")
}

# Segunda seccion: Seleccion de programas si "Instalar programas" esta seleccionado
if($selectedTareas -contains "Install programs") {
    $programs = @(
        "Microsoft.VisualStudioCode",
        "CoreyButler.NVMforWindows",
        "Microsoft.WindowsTerminal",
        "JanDeDobbeleer.OhMyPosh",
        "Microsoft.Powershell",
        "Python.Python.3.12",
        "Discord.Discord",
        "Neovim.Neovim",
        "Google.Chrome",
        "Valve.Steam",
        "Brave.Brave",
        "Chocolatey.Chocolatey",
        "Obsidian.Obsidian"
    )

    $selectedPrograms = Show-SelectionMenu -optionList $programs -prompt "Select the programs you want to install"
    
    foreach ($program in $selectedPrograms) {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT" -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host "`t` ■ Instalando $program " -ForegroundColor $textWhite -Background Blue
        Write-Host " "
        Install-Program -programName $program
    }
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
}


Write-Host " Completed tasks close this terminal and start a new. " -ForegroundColor $textBlack -Background $warning
