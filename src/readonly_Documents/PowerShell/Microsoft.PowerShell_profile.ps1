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
function cm() { chezmoi $args }
function cmad() { chezmoi add $args }
function cmap() { chezmoi apply $args }
function cmcd() { chezmoi cd $args }
function cmd() { chezmoi diff $args }
function cmed() { chezmoi edit $args }
function cmg() { chezmoi git -- $args }
function cmga() { chezmoi git -- add $args }
function cmgd() { chezmoi git -- diff $args }
function cmgl() { chezmoi git -- log --oneline $args }
function cmgs() { chezmoi git -- status --short $args }
function cmgsh() { chezmoi git -- show $args }
function cmup() { chezmoi update $args }
function g() { git $args }
function ga() { git add $args }
function gb() { git branch -v $args }
function gba() { git branch -a $args }
function gbd() { git branch -d $args }
function gbl() { git blame $args }
function gc() { git commit $args }
function gca() { git commit --amend $args }
function gd() { git diff $args }
function gdc() { git diff --cached $args }
function gds() { git diff --stat $args }
function gf() { git fetch $args }
function gl() { git log --oneline $args }
function glf() { git log --format=fuller --stat $args }
function glg() { git log --oneline --graph $args }
function gll() { git log $args }
function gls() { git log --oneline --stat $args }
function glsf() { git ls-files $args }
function gmv() { git mv $args }
function gpl() { git pull $args }
function gps() { git push $args }
function grb() { git rebase $args }
function grbi() { git rebase -i $args }
function grm() { git rm $args }
function grs() { git restore $args }
function grst() { git reset $args }
function grv() { git revert $args }
function gs() { git status --short $args }
function gsh() { git show $args }
function gsl() { git status $args }
function gw() { git switch $args }
