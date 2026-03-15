# dot.ps1 - Windows dotfiles management command
# Mirrors the 'dot' bash command from bin/dot (Mac/Linux)
# Usage: dot <command>

param([string]$Command = "help", [string[]]$Args)

$DOTFILES_DIR = "$env:USERPROFILE\.dotfiles"

function sub_help {
    Write-Host "Usage: dot <command>" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "   clean      Clean up caches (scoop, pip, npm)"
    Write-Host "   edit       Open dotfiles in VS Code"
    Write-Host "   help       This help message"
    Write-Host "   test       Run tests"
    Write-Host "   update     Update packages (scoop, winget, npm, pip)"
}

function sub_edit {
    code $DOTFILES_DIR
}

function sub_clean {
    Write-Host "-- Scoop cache -------------------------------------------------------" -ForegroundColor Cyan
    scoop cache rm *

    Write-Host "-- npm cache ---------------------------------------------------------" -ForegroundColor Cyan
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm cache clean --force
    } else {
        Write-Host "   npm not found, skipping" -ForegroundColor Yellow
    }

    Write-Host "-- pip cache ---------------------------------------------------------" -ForegroundColor Cyan
    if (Get-Command pip -ErrorAction SilentlyContinue) {
        pip cache purge
    } else {
        Write-Host "   pip not found, skipping" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "[OK] Caches cleaned." -ForegroundColor Green
}

function sub_test {
    $testDir = Join-Path $DOTFILES_DIR "test"
    if (Test-Path $testDir) {
        if (Get-Command bats -ErrorAction SilentlyContinue) {
            bats "$testDir\*.bats"
        } else {
            Write-Host "[!!] bats not found -- install it first" -ForegroundColor Yellow
        }
    } else {
        Write-Host "[!!] No test directory found at $testDir" -ForegroundColor Yellow
    }
}

function sub_update {
    Write-Host "-- Scoop -------------------------------------------------------------" -ForegroundColor Cyan
    scoop update
    scoop update *

    Write-Host "-- winget ------------------------------------------------------------" -ForegroundColor Cyan
    winget upgrade --all --silent --accept-package-agreements --accept-source-agreements

    Write-Host "-- npm ---------------------------------------------------------------" -ForegroundColor Cyan
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm update -g
    } else {
        Write-Host "   npm not found, skipping" -ForegroundColor Yellow
    }

    Write-Host "-- pip ---------------------------------------------------------------" -ForegroundColor Cyan
    if (Get-Command pip -ErrorAction SilentlyContinue) {
        pip list --outdated --format=json | python -c "import sys,json; [print(p['name']) for p in json.load(sys.stdin)]" | ForEach-Object { pip install -U $_ }
    } else {
        Write-Host "   pip not found, skipping" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "[OK] All packages updated." -ForegroundColor Green
}

switch ($Command) {
    "help"   { sub_help }
    "edit"   { sub_edit }
    "clean"  { sub_clean }
    "test"   { sub_test }
    "update" { sub_update }
    default  {
        Write-Host "'$Command' is not a known command." -ForegroundColor Red
        Write-Host ""
        sub_help
        exit 1
    }
}
