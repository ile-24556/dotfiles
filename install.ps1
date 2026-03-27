# Install small set of tools and apply chezmoi on Windows.

$ErrorActionPreference = 'stop'
Set-StrictMode -Version 3.0
Set-PSDebug -Trace 1

if ( -not $IsWindows ) {
    Write-Error "This script is supported only on Windows."
    exit 1
}

New-Variable MISE_VERSION -option Constant -Scope Private -value '2026.2.24'

Write-Output 'Installing tools as administrator ...'

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

########################################
# WinGet apps
########################################

# Accept WinGet agreements beforehand in CI
if ($env:GITHUB_ACTIONS) {
    winget list --accept-source-agreements
}

function Invoke-WinGetInstallation([string]$id, [string]$commandName) {
    if (Get-Command "$commandName" -ErrorAction SilentlyContinue) {
        return
    }
    winget install --exact --id "$id"
}

Invoke-WinGetInstallation 'Git.Git'                 'git'
Invoke-WinGetInstallation 'GitHub.cli'              'gh'
Invoke-WinGetInstallation 'GoLang.Go'               'go'
Invoke-WinGetInstallation 'Microsoft.PowerShell'    'pwsh'
Invoke-WinGetInstallation 'Rustlang.Rustup'         'rustup'
Invoke-WinGetInstallation 'twpayne.chezmoi'         'chezmoi'

########################################
# Append paths
########################################

$env:Path += '' `
    + ";$env:LocalAppData\Microsoft\WinGet\Packages\twpayne.chezmoi_Microsoft.Winget.Source_8wekyb3d8bbwe" `
    + ";$env:ProgramFiles\Git\cmd" `
    + ";$env:ProgramFiles\GitHub CLI" `
    + ";$env:ProgramFiles\Go\bin" `
    + ";$HOME\.cargo\bin" `
    + ";$HOME\.local\bin" `

########################################
# Tools written in Rust
########################################

if (-not (Get-Command cargo-binstall -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Unrestricted -Scope Process
    Invoke-Expression (
        Invoke-WebRequest "https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.ps1"
    ).Content
}

cargo binstall --disable-strategies compile -y -- `
    bat `
    dprint `
    mise@$MISE_VERSION `
    ripgrep `
    starship `
    uv `

########################################
# chezmoi
########################################

if ($env:GITHUB_ACTIONS) {
    chezmoi init --apply --source-path .
} else {
    chezmoi init --apply 'ile-24556'
}

########################################
# start developping dotfiles
########################################

if (-not (Get-Command pre-commit -ErrorAction SilentlyContinue)) {
    uv tool install pre-commit
}
Set-Location "$HOME\.local\share\chezmoi"
pre-commit install

Invoke-WinGetInstallation 'rhysd.actionlint' 'actionlint'
