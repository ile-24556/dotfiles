# Install tools ommited from 'install.ps1'.

if ( -not $IsWindows ) {
    Write-Error "This script is supported only on Windows."
    exit 1
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

cargo binstall --disable-strategies compile -- fd-find oxipng

Update-Everything
