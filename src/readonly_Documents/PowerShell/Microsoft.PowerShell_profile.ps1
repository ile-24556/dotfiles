# Import-Module posh-git
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme agnosterplus
Invoke-Expression (&starship init powershell)

# 2024-08-10
$Env:PYTHONUTF8 = 1
$Env:PYTHONDEFAULTENCODING = 1 # doesn't work

$Env:BAT_CONFIG_PATH = "$HOME\.config\bat\config"
$Env:DPRINT_CONFIG_DIR = "$HOME\.config\dprint"

# UTF-8で出力するプログラム（wavpack等）の文字化けを防ぐ - 2024-10-14
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

Set-Variable months -Option Constant -Scope Private -Value ([String[]]@(
    '01月', '02月', '03月', '04月', '05月', '06月',
    '07月', '08月', '09月', '10月', '11月', '12月',
    ''
))
Set-Variable culture -Option Constant -Scope Private -Value (Get-Culture -Name ja-JP).Clone()
$culture.DateTimeFormat.DateSeparator                 = "-"
$culture.DateTimeFormat.FirstDayOfWeek                = "Monday"
$culture.DateTimeFormat.FullDateTimePattern           = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
$culture.DateTimeFormat.LongDatePattern               = "yyyy-MM-dd"
$culture.DateTimeFormat.LongTimePattern               = "HH:mm:ss"
$culture.DateTimeFormat.MonthDayPattern               = "MM-dd"
$culture.DateTimeFormat.ShortDatePattern              = "yyyy-MM-dd"
$culture.DateTimeFormat.ShortTimePattern              = "HH:mm"
$culture.DateTimeFormat.YearMonthPattern              = "yyyy-MM"
$culture.DateTimeFormat.AbbreviatedMonthNames         = $months
$culture.DateTimeFormat.MonthNames                    = $months
$culture.DateTimeFormat.AbbreviatedMonthGenitiveNames = $months
$culture.DateTimeFormat.MonthGenitiveNames            = $months
[System.Threading.Thread]::CurrentThread.CurrentCulture   = $culture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = $culture

# 2026-02-28
function rgn() {
    rg -t md $args "$HOME/Documents/notes/"
}
# Aliases - 2026-03-03
Set-Alias -Name open -Value explorer
Set-Alias -Name ex -Value explorer
function bh() {
    bat --plain --language=help $args
}
function bm() {
    bat --plain --language=man $args
}
function ga() {
    git add $args
}
function gb() {
    git branch -v $args
}
function gbd() {
    git branch -d $args
}
function gbD() {
    git branch -D $args
}
function gc() {
    git commit $args
}
function gca() {
    git commit --amend $args
}
function gd() {
    git diff $args
}
function gdc() {
    git diff --cached $args
}
function gl() {
    git log --oneline $args
}
function glf() {
    git log --format=fuller --date=iso-strict-local $args
}
function glg() {
    git log --oneline --graph $args
}
function gll() {
    git log --date=iso-strict-local $args
}
function glsf() {
    git ls-files $args
}
function gmv() {
    git mv $args
}
function grb() {
    git rebase $args
}
function grm() {
    git rm $args
}
function grs() {
    git restore $args
}
function grst() {
    git reset $args
}
function grv() {
    git revert $args
}
function gs() {
    git status --short $args
}
function gsh() {
    git show $args
}
function gsl() {
    git status $args
}
function gw() {
    git switch $args
}



# mise-en-plus - 2026-02-23
$env:MISE_SHELL = 'pwsh'
if (-not (Test-Path -Path Env:/__MISE_ORIG_PATH)) {
    $env:__MISE_ORIG_PATH = $env:PATH
}

function mise {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments=$true)]  # Allow any number of arguments, including none
        [string[]] $arguments
    )

    $previous_out_encoding = $OutputEncoding
    $previous_console_out_encoding = [Console]::OutputEncoding
    $OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

    function _reset_output_encoding {
        $OutputEncoding = $previous_out_encoding
        [Console]::OutputEncoding = $previous_console_out_encoding
    }

    if ($arguments.count -eq 0) {
        & "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe"
        _reset_output_encoding
        return
    } elseif ($arguments -contains '-h' -or $arguments -contains '--help') {
        & "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" @arguments
        _reset_output_encoding
        return
    }

    $command = $arguments[0]
    if ($arguments.Length -gt 1) {
        $remainingArgs = $arguments[1..($arguments.Length - 1)]
    } else {
        $remainingArgs = @()
    }

    switch ($command) {
        { $_ -in 'deactivate', 'shell', 'sh' } {
            & "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" $command @remainingArgs | Out-String | Invoke-Expression -ErrorAction SilentlyContinue
            _reset_output_encoding
        }
        default {
            & "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" $command @remainingArgs
            $status = $LASTEXITCODE
            if ($(Test-Path -Path Function:\_mise_hook)){
                _mise_hook
            }
            _reset_output_encoding
            # Pass down exit code from mise after _mise_hook
            if ($PSVersionTable.PSVersion.Major -ge 7) {
                pwsh -NoProfile -Command exit $status
            } else {
                powershell -NoProfile -Command exit $status
            }
        }
    }
}

function Global:_mise_hook {
    if ($env:MISE_SHELL -eq "pwsh"){
        $output = & "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" hook-env $args -s pwsh | Out-String
        if ($output -and $output.Trim()) {
            $output | Invoke-Expression
        }
    }
}

function __enable_mise_chpwd{
    if ($PSVersionTable.PSVersion.Major -lt 7) {
        if ($env:MISE_PWSH_CHPWD_WARNING -ne '0') {
            Write-Warning "mise: chpwd functionality requires PowerShell version 7 or higher. Your current version is $($PSVersionTable.PSVersion). You can add `$env:MISE_PWSH_CHPWD_WARNING=0` to your environment to disable this warning."
        }
        return
    }
    if (-not $__mise_pwsh_chpwd){
        $Global:__mise_pwsh_chpwd= $true
        $_mise_chpwd_hook = [EventHandler[System.Management.Automation.LocationChangedEventArgs]] {
            param([object] $source, [System.Management.Automation.LocationChangedEventArgs] $eventArgs)
            end {
                _mise_hook
            }
        };
        $__mise_pwsh_previous_chpwd_function=$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction;

        if ($__mise_original_pwsh_chpwd_function) {
            $ExecutionContext.SessionState.InvokeCommand.LocationChangedAction = [Delegate]::Combine($__mise_pwsh_previous_chpwd_function, $_mise_chpwd_hook)
        }
        else {
            $ExecutionContext.SessionState.InvokeCommand.LocationChangedAction = $_mise_chpwd_hook
        }
    }
}
__enable_mise_chpwd
Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_chpwd

function __enable_mise_prompt {
    if (-not $__mise_pwsh_previous_prompt_function){
        $Global:__mise_pwsh_previous_prompt_function=$function:prompt
        function global:prompt {
            if (Test-Path -Path Function:\_mise_hook){
                _mise_hook
            }
            & $__mise_pwsh_previous_prompt_function
        }
    }
}
__enable_mise_prompt
Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_prompt

_mise_hook
if (-not $__mise_pwsh_command_not_found){
    $Global:__mise_pwsh_command_not_found= $true
    function __enable_mise_command_not_found {
        $_mise_pwsh_cmd_not_found_hook = [EventHandler[System.Management.Automation.CommandLookupEventArgs]] {
            param([object] $Name, [System.Management.Automation.CommandLookupEventArgs] $eventArgs)
            end {
                if ([Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems()[-1].CommandLine -match ([regex]::Escape($Name))) {
                    if (& "C:\Users\marun\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" hook-not-found -s pwsh -- $Name){
                        _mise_hook
                        if (Get-Command $Name -ErrorAction SilentlyContinue){
                            $EventArgs.Command = Get-Command $Name
                            $EventArgs.StopSearch = $true
                        }
                    }
                }
            }
        }
        $current_command_not_found_function = $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction
        if ($current_command_not_found_function) {
            $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = [Delegate]::Combine($current_command_not_found_function, $_mise_pwsh_cmd_not_found_hook)
        }
        else {
            $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $_mise_pwsh_cmd_not_found_hook
        }
    }
    __enable_mise_command_not_found
    Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_command_not_found
}
