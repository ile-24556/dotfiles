# Install small set of tools and apply chezmoi.

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

Function Command-Exists {
    param (
        [Parameter(Mandatory)]
        [ValidateCount(1, 1)]
        [string[]]$CommandName
    )

    $OldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {
        if (Get-Command $CommandName) {
            return $true
        }
    } catch {
        return $false
    } finally {
        $ErrorActionPreference=$OldPreference
    }
}

# Accept WinGet agreements beforehand in CI
if ($env:GITHUB_ACTIONS) {
    winget list --accept-source-agreements
}

if (-not (Command-Exists git)) {
    winget install --exact --id 'Git.Git'
}
if (-not (Command-Exists gh)) {
    winget install --exact --id 'GitHub.cli'
}
if (-not (Command-Exists pwsh)) {
    winget install --exact --id 'Microsoft.PowerShell'
}
if (-not (Command-Exists rustup)) {
    winget install --exact --id 'Rustlang.Rustup'
}
if (-not (Command-Exists chezmoi)) {
    winget install --exact --id 'twpayne.chezmoi'
}

# winget install --exact --id '7zip.7zip'
# winget install --exact --id 'AgileBits.1Password'
# winget install --exact --id 'Canonical.Ubuntu.2404'
# winget install --exact --id 'Google.JapaneseIME'
# winget install --exact --id 'Microsoft.PowerToys'
# winget install --exact --id 'Microsoft.VisualStudio.2022.BuildTools'
# winget install --exact --id 'Microsoft.VisualStudioCode'
# winget install --exact --id 'Microsoft.VisualStudioCode.CLI'
# winget install --exact --id 'Microsoft.WindowsTerminal'
# winget install --exact --id 'Microsoft.WSL'
# winget install --exact --id 'Obsidian.Obsidian'

########################################
# Append paths
########################################

$env:Path += '' `
    + ";$env:ProgramFiles\Git\cmd" `
    + ";$env:ProgramFiles\GitHub CLI" `
    + ";$HOME\.cargo\bin" `
    + ";$HOME\.local\bin" `
    + ";$env:LocalAppData\Microsoft\WinGet\Packages\twpayne.chezmoi_Microsoft.Winget.Source_8wekyb3d8bbwe" `

########################################
# Tools written in Rust
########################################

if (-not (Command-Exists cargo-binstall)) {
    Set-ExecutionPolicy Unrestricted -Scope Process
    Invoke-Expression (
        Invoke-WebRequest "https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.ps1"
    ).Content
}

cargo binstall --locked -y -- `
    bat `
    dprint `
    fd-find `
    mise `
    oxipng `
    ripgrep `
    starship `
    uv `

########################################
# chezmoi
########################################

if ($env:GITHUB_ACTIONS) {
    chezmoi init --source-path .
} else {
    chezmoi init 'ile-24556'
}
chezmoi apply

########################################
# start developping dotfiles
########################################

if (-not (Command-Exists pre-commit)) {
    uv tool install
}
Set-Location "$HOME\.local\share\chezmoi"
pre-commit install

mise install go
go install 'github.com/rhysd/actionlint/cmd/actionlint@latest'
