#-------------------------------------------------------------------------------#
#                                                                               #
# This script installs all the stuff I need to develop the things I develop.    #
# Run PowerShell with admin priveleges, type `env-windows`, and go make coffee. #
#                                                                               #
#                                                                        -James #
#                                                                               #
#-------------------------------------------------------------------------------#

#
# Functions
#

function Update-Environment-Path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Package Managers
#

# Choco
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | iex
Update-Environment-Path

#
# Git
#

choco install git --yes --params '/GitAndUnixToolsOnPath'
choco install tortoisegit --yes
Update-Environment-Path
git config --global alias.pom 'pull origin master'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"


#
# VS Code
#

choco install vscode --yes
Update-Environment-Path
code --install-extension vscode-icons
code --install-extension vscode-ember-frost
code --install-extension vscode-gitlens

# PowerShell support
code --install-extension vscode-powershell

# CSharp support
code --install-extension vscode-csharp

#
# Eclipse
# 
choco install eclipse --yes

#
# Android Studio
# 
choco install androidstudio --yes

#
# Android Studio SDK 26.1.1
# 
choco install android-sdk --yes

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install filezilla --yes

# Browsers
choco install googlechrome --yes

Update-Environment-Path

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
