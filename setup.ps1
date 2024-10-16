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
    "Install and configure Neovim",
    "Install and customize terminal"
)

$selectedTareas = Show-SelectionMenu -optionList $tareas -prompt "Select the areas you want to perform"

# Si selecciona "Instalacion completa", automaticamente selecciona todas las opciones
if ($selectedTareas -contains "Install a new environment") {
    $selectedTareas = @("Install programs", "Install and configure Neovim", "Install and customize terminal")
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
        Write-Host "`t` ■ Installing $program " -ForegroundColor $textWhite -Background Blue
        Write-Host " "
        Install-Program -programName $program
    }
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
}

# Funcion para configurar neovim
if ($selectedTareas -contains "Install and configure Neovim") {
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Checking and installing requirements for Neovim... " -ForegroundColor $textBlack -Background $secondary
    Write-Host " "
    try {
        scoop -v
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
        Write-Host " "
        Write-Host " Checking and installing requirements for Neovim... " -ForegroundColor $textBlack -Background $secondary
        Write-Host " "
        Write-Host "`t` Installing GCC using Scoop..." -ForegroundColor $textWhite -BackgroundColor Blue
        Write-Host " "
        scoop install gcc
    } catch {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
        Write-Host " "
        Write-Host " Checking and installing requirements for Neovim... " -ForegroundColor $textBlack -Background $secondary
        Write-Host " "
        Write-Host "`t` Scoop not found. Installing Scoop... " -ForegroundColor $textWhite -BackgroundColor Blue
        Write-Host " "
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        Write-Host " "
        # Después de instalar Scoop, instalar GCC también
        Write-Host "`t` Installing GCC using Scoop... " -ForegroundColor $textWhite -BackgroundColor Blue
        Write-Host " "
        scoop install gcc
    }
    
    # Verificar si ripgrep está instalado usando winget
    $rgStatus = winget list --id BurntSushi.ripgrep.MSVC -q
    if ($rgStatus -eq $null) {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
        Write-Host " "
        Write-Host "`t` Checking and installing requirements for Neovim... " -ForegroundColor $textBlack -Background $secondary
        Write-Host " "
        Write-Host "`t` ripgrep not found. Installing ripgrep... " -ForegroundColor $textWhite -BackgroundColor Blue
        winget install BurntSushi.ripgrep.MSVC
    } else {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
        Write-Host " "
        Write-Host "`t` - Required programs installed successfully." -ForegroundColor $textBlack -BackgroundColor $warning

    }
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` - Required programs installed successfully." -ForegroundColor $textBlack -BackgroundColor $success

    # Copiar configuración de Neovim desde .dotfiles
    $sourcePath = "$HOME\.dotfiles\common\nvim"
    $destinationPath = "$env:LOCALAPPDATA\nvim"

    if (Test-Path $sourcePath) {
        Copy-Item -Recurse -Path $sourcePath -Destination $destinationPath -Force
        Write-Host "`t` - Neovim configuration copied successfully." -ForegroundColor $textBlack -BackgroundColor $success
    } else {
        Write-Host "`t` - Error: Neovim configuration folder not found in .dotfiles." -ForegroundColor $textWhite -BackgroundColor Red
    }
    Start-Sleep -Seconds 2
}

# Configuración e instalación de terminal si está seleccionado
if ($selectedTareas -contains "Install and customize terminal") {

    & $gitPath $clone $repo $ruteClone

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Neovim configuration IDE. " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Installing Terminal Icons... " -ForegroundColor $textBlack -Background $secondary

    # Terminal-Icons install
    Start-Process pwsh -ArgumentList '-NoProfile -Command "Install-Module -Name Terminal-Icons -Repository PSGallery -Force"' -Wait

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT" -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Neovim configuration IDE. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Installing JetBrainsMono NerdFont... " -ForegroundColor $textBlack -Background $secondary

    # oh-my-posh font install
    Start-Process pwsh -ArgumentList "-NoProfile -Command `"$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe font install JetBrainsMono`"" -Wait

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Neovim configuration IDE. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " - Oh-my-posh installed and configured fonts " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Configuring files... " -ForegroundColor $textBlack -Background $secondary

    Start-Sleep -Seconds 2
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " - Programs installed succesfully. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Neovim configuration IDE. " -ForegroundColor $textBlack -Background $success
    Write-Host " - Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " - Oh-my-posh installed and configured fonts " -ForegroundColor $textBlack -Background $success
    Write-Host " - File configs required configured " -ForegroundColor $textBlack -Background $success
    # Copy Windows Terminal configuration
    $terminalConfigPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    if (-Not (Test-Path -Path $terminalConfigPath)) {
        New-Item -ItemType Directory -Force -Path $terminalConfigPath
    }

    Copy-Item -Path "$env:USERPROFILE\.dotfiles\windows\terminal\settings.json" -Destination "$terminalConfigPath\settings.json" -Force

    # Copy PowerShell configuration
    # Asigna manualmente la ruta correcta a la variable $PROFILE
    $PROFILE = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

    # Obtiene el directorio del perfil
        $profileDirectory = Split-Path -Path $PROFILE -Parent
    
    # Verifica si el directorio del perfil no existe y lo crea si es necesario
    if (-Not (Test-Path -Path $profileDirectory)) {
        New-Item -ItemType Directory -Force -Path $profileDirectory
    }
    
    # Copia el archivo de perfil de PowerShell al destino especificado en $PROFILE
    Copy-Item -Path "$env:USERPROFILE\.dotfiles\windows\powershell\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
    
}

Write-Host " "
Write-Host " Completed tasks close this terminal and start a new. " -ForegroundColor $textBlack -Background $warning
