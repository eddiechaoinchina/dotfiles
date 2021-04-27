# Author: Will Chao <nerdzzh@gmail.com>
# Filename: Microsoft.PowerShell_profile.ps1
# Last Change: 2021/4/27 8:27:58 +0800
# Brief: My PowerShell_profile File

# Preamble -------------------------------------- {{{

# Install chocolatey first and install "bat" with it, this will install "less"
# alongside. The chocolatey profile was generated automatically during the
# installation, remove it before use.
#
# Install "coreutils", "grep", "diffutils", "less", "tree" from gnuwin32
# project. Change the name "tree" to "treeview" to avoid confilcts with
# powershell's original tree command.
#
# Insatll "curl" and "es", both great tools.
#
# Follow steps on microsoft webpage to configure the theme.

# }}}

# Variables ------------------------------------- {{{

$env:BAT_THEME="Coldark-Dark"

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

Set-Alias cat bat
Set-Alias tree treeview

# }}}

# Theme ----------------------------------------- {{{

Import-Module posh-git
Import-Module oh-my-posh

Set-Theme robbyrussell

# }}}

# Chocolatey profile ---------------------------- {{{

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# }}}
