# Starship prompt
Invoke-Expression (&starship init powershell)

# Enviroment variables
$Env:BAT_CONFIG_PATH = "$HOME\.config\bat\config"
$Env:DPRINT_CONFIG_DIR = "$HOME\.config\dprint"
$Env:PYTHONDEFAULTENCODING = 1 # doesn't work
$Env:PYTHONUTF8 = 1

# Output encoding
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

# Preferred datetime format
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

# Aliases
function rgn() { rg -t md $args "$HOME/Documents/notes/" }
Set-Alias -Name open -Value explorer
Set-Alias -Name ex -Value explorer
function bh() { bat --plain --language=help $args }
function bm() { bat --plain --language=man $args }
function ga() { git add $args }
function gb() { git branch -v $args }
function gbd() { git branch -d $args }
function gbD() { git branch -D $args }
function gc() { git commit $args }; Remove-Alias gc -Force
function gca() { git commit --amend $args }
function gd() { git diff $args }
function gdc() { git diff --cached $args }; Remove-Alias gl -Force
function gl() { git log --oneline $args }
function glf() { git log --format=fuller --date=iso-strict-local $args }
function glg() { git log --oneline --graph $args }
function gll() { git log --date=iso-strict-local $args }
function glsf() { git ls-files $args }
function gmv() { git mv $args }
function grb() { git rebase $args }
function grm() { git rm $args }
function grs() { git restore $args }
function grst() { git reset $args }
function grv() { git revert $args }
function gs() { git status --short $args }
function gsh() { git show $args }
function gsl() { git status $args }
function gw() { git switch $args }
