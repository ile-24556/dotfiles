# Install tools ommited from 'install.ps1'.

if ( -not $IsWindows ) {
    Write-Error "This script is supported only on Windows."
    exit 1
}

# winget install --exact --id '7zip.7zip'
# winget install --exact --id 'AgileBits.1Password'
# winget install --exact --id 'Amazon.Music'
# winget install --exact --id 'Google.JapaneseIME'
# winget install --exact --id 'JTKsoftware.JoyToKey'
# winget install --exact --id 'Microsoft.PowerToys'
# winget install --exact --id 'Microsoft.VisualStudio.2022.BuildTools'
# winget install --exact --id 'Microsoft.VisualStudioCode'
# winget install --exact --id 'Microsoft.VisualStudioCode.CLI'
# winget install --exact --id 'Microsoft.WindowsTerminal'
# winget install --exact --id 'Obsidian.Obsidian'
# winget install --exact --id 'PeterPawlowski.foobar2000'
# winget install --exact --id 'Valve.Steam'
# winget install --exact --id 'ZedIndustries.Zed'
# winget install --exact --id 'Zen-Team.Zen-Browser'

cargo binstall --disable-strategies compile -- fd-find oxipng

# Ubuntu on WSL
# winget install --exact --id 'Microsoft.WSL'
# wsl --install 'Ubuntu-24.04'

Update-Everything
