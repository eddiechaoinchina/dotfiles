# Author: Will Chao <nerdzzh@gmail.com>
# Filename: Microsoft.PowerShell_profile.ps1
# Last Change: 2021/4/26 23:51:21 +0800
# Brief: My PowerShell_profile File

# Preamble -------------------------------------- {{{

# Install chocolatey first.

# Install "bat" with choco.

# Insatll "curl" and "es".

# Install "coreutils", "grep", "diffutils", "less", "tree" from gnuwin32
# project.

# Follow steps on microsoft webpage to configure the theme.

# }}}

$env:BAT_THEME="Coldark-Dark"

# Initialize theme ------------------------------ {{{

# Follow steps on ms webpage to use these modules.

Import-Module posh-git
Import-Module oh-my-posh

Set-Theme robbyrussell

# }}}

# Aliases --------------------------------------- {{{

Remove-Item alias:cp -force
Remove-Item alias:ls -force
Remove-Item alias:rm -force

Remove-Item alias:cat -force
Remove-Item alias:dir -force
Remove-Item alias:pwd -force

Remove-Item alias:diff -force
Remove-Item alias:echo -force
Remove-Item alias:curl -force

Remove-Item alias:rmdir -force

Set-Alias tree "tree /f"
Set-Alias cat bat

# }}}

# Chocolatey profile ---------------------------- {{{

# This is added automatically by choco installation.

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# }}}
