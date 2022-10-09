# Locale region and language install
Install-Language es-ES
Set-WinUserLanguageList -LanguageList es-ES -Force
Set-WinSystemLocale es-ES
Set-Culture es-Es
tzutil /s "Romance Standard Time"
PowerShell Set-WinHomeLocation -GeoID 217 # Number locale


# Enable remote desktop
Enable-PSRemoting
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Desktop Users -Member vagrant

 # Install Boxstarter
    . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Fix Windows Explorer
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Install apps
choco config set --name="'UseLanguage'" --value="'es'" 
choco install -y firefox
choco install -y 7zip
choco install -y notepadplusplus
choco install -y vscode
choco install git -y -params '"/GitAndUnixToolsOnPath /NoAutoCrlf"'
choco install -y winrar
choco install -y anydesk.install
choco install -y adobereader
dism /online /get-targeteditions #server 2022
dism /online /set-edition:serverstandard /productkey:VDYBN-27WPP-V4HQT-9VMD4-VMK7H /accepteula -y #server 2022

# SQL Server 2017
#choco install -y sql-server-2017 --params='/SAPWD="Indigo12!" /SECURITYMODE=sql'
#choco install -y sql-server-management-studio
