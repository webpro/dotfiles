# Windows Setup Script
# Run this in PowerShell as a regular user (NOT as Administrator)
# Scoop requires non-admin context. winget will prompt for UAC per-package if needed.

Write-Host "→ Starting Windows setup..." -ForegroundColor Cyan

# Warn if running as Administrator — Scoop will fail
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "⚠ Running as Administrator — Scoop will refuse to install." -ForegroundColor Red
    Write-Host "  Re-run this script in a normal (non-elevated) PowerShell session." -ForegroundColor Red
    exit 1
}

# ─── winget ──────────────────────────────────────────────────────────────────

# Install winget if not present (comes with Windows 11 by default)
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "→ Installing winget..." -ForegroundColor Yellow
    Write-Host "Please install App Installer from the Microsoft Store to get winget" -ForegroundColor Yellow
    exit 1
}

# Install packages from winget-packages.txt
Write-Host "→ Installing Windows packages via winget..." -ForegroundColor Cyan
$packagesFile = Join-Path $PSScriptRoot "winget-packages.txt"
if (Test-Path $packagesFile) {
    Get-Content $packagesFile | Where-Object { $_ -notmatch '^\s*#' -and $_ -match '\S' } | ForEach-Object {
        Write-Host "  Installing: $_" -ForegroundColor Green
        winget install --id $_ --silent --accept-package-agreements --accept-source-agreements
    }
}

# ─── Scoop (CLI tools) ──────────────────────────────────────────────────────

Write-Host "→ Setting up Scoop..." -ForegroundColor Cyan
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "  Scoop already installed" -ForegroundColor Green
}

# Refresh PATH so 'scoop' is available in this session immediately after install
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","User") + ";" + $env:PATH

Write-Host "→ Adding Scoop buckets..." -ForegroundColor Cyan
scoop bucket add extras
scoop bucket add nerd-fonts

Write-Host "→ Installing CLI tools via Scoop..." -ForegroundColor Cyan
$scoopPackages = @(
    "starship",
    "kanata",
    "bat",
    "eza",
    "fd",
    "ripgrep",
    "fzf",
    "zoxide",
    "lazygit",
    "jq",
    "delta"
)
foreach ($pkg in $scoopPackages) {
    Write-Host "  Installing: $pkg" -ForegroundColor Green
    scoop install $pkg
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ⚠ Failed to install $pkg (exit $LASTEXITCODE)" -ForegroundColor Yellow
    }
}

Write-Host "→ Installing Nerd Fonts via Scoop..." -ForegroundColor Cyan
scoop install nerd-fonts/JetBrainsMono-NF

# ─── Deploy config files ────────────────────────────────────────────────────

# Windows Terminal settings.json
Write-Host "→ Deploying Windows Terminal settings..." -ForegroundColor Cyan
$wtSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$wtSource = Join-Path $PSScriptRoot "windows-terminal-settings.json"
if (Test-Path $wtSettingsDir) {
    $wtTarget = Join-Path $wtSettingsDir "settings.json"
    if (Test-Path $wtTarget) {
        Copy-Item $wtTarget "$wtTarget.bak" -Force
        Write-Host "  Backed up existing settings to settings.json.bak" -ForegroundColor Yellow
    }
    Copy-Item $wtSource $wtTarget -Force
    Write-Host "  ✓ Windows Terminal settings deployed" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Windows Terminal not found — install it first, then re-run" -ForegroundColor Yellow
}

# Starship config
Write-Host "→ Deploying Starship config..." -ForegroundColor Cyan
$starshipDir = "$env:USERPROFILE\.config"
if (-not (Test-Path $starshipDir)) {
    New-Item -ItemType Directory -Path $starshipDir -Force | Out-Null
}
$starshipSource = Join-Path $PSScriptRoot "starship.toml"
$starshipTarget = Join-Path $starshipDir "starship.toml"
Copy-Item $starshipSource $starshipTarget -Force
Write-Host "  ✓ Starship config deployed to $starshipTarget" -ForegroundColor Green

# Global gitignore
Write-Host "→ Deploying global gitignore..." -ForegroundColor Cyan
$gitignoreSource = Join-Path $PSScriptRoot "gitignore-global"
$gitignoreTarget = "$env:USERPROFILE\.gitignore-global"
Copy-Item $gitignoreSource $gitignoreTarget -Force
git config --global core.excludesFile "$gitignoreTarget"
Write-Host "  ✓ Global gitignore deployed" -ForegroundColor Green

# ─── Starship init in PowerShell profile ─────────────────────────────────────

Write-Host "→ Configuring Starship in PowerShell profile..." -ForegroundColor Cyan
$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}
$starshipInit = 'Invoke-Expression (&starship init powershell)'
if (-not (Select-String -Path $PROFILE -Pattern 'starship init' -Quiet -ErrorAction SilentlyContinue)) {
    Add-Content -Path $PROFILE -Value "`n# Starship prompt`n$starshipInit"
    Write-Host "  ✓ Starship init added to PowerShell profile" -ForegroundColor Green
} else {
    Write-Host "  Starship already in PowerShell profile" -ForegroundColor Green
}

# ─── Done ────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "✓ Windows setup complete!" -ForegroundColor Green
