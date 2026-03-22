Write-Output 'Installing tools on Windows.'

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

# winget install --exact --id '7zip.7zip'
# winget install --exact --id 'AgileBits.1Password'
# winget install --exact --id 'Canonical.Ubuntu.2404'
winget install --exact --id 'Git.Git'
winget install --exact --id 'GitHub.cli'
# winget install --exact --id 'Google.JapaneseIME'
# winget install --exact --id 'ImageMagick.ImageMagick'
# winget install --exact --id 'jdx.mise'
# winget install --exact --id 'Microsoft.PowerShell'
# winget install --exact --id 'Microsoft.PowerToys'
# winget install --exact --id 'Microsoft.VisualStudio.2022.BuildTools'
# winget install --exact --id 'Microsoft.VisualStudioCode'
# winget install --exact --id 'Microsoft.WindowsTerminal'
# winget install --exact --id 'Microsoft.WSL'
# winget install --exact --id 'Obsidian.Obsidian'
winget install --exact --id 'Rustlang.Rustup'
# winget install --exact --id 'twpayne.chezmoi'

########################################
# Tools written in Rust
########################################

Write-Output 'Installing cargo binaries'
cargo binstall --locked -y -- `
    bat `
    dprint `
    oxipng `
    ripgrep `
    starship `
    uv `

########################################
# pre-commit
########################################

uv tool install pre-commit
Set-Location "${HOME}/.local/share/chezmoi/"
pre-commit install

########################################

exit
