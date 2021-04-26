# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module posh-git
Import-Module oh-my-posh

Set-Theme robbyrussell

Remove-Item alias:diff -force # use gnu diff

Remove-Item alias:cat -force
Set-Alias cat bat # bat instead of cat

Clear-Host # clear the greeting message before opening
