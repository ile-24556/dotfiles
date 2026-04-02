$ErrorActionPreference = 'stop'
Set-StrictMode -Version 3.0
Set-PSDebug -Trace 1

foreach ($prof in (Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles\*.default*\").FullName) {
    Copy-Item -Force -Recurse -Path "$HOME\.local\share\chezmoi\manual_install\firefox\*" -Destination $prof
}
