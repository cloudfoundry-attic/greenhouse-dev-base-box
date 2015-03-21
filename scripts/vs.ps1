## Set up Visual Studio
#Write-Host "Installing Visual Studio..."
#$vsIsoPath = "C:\windows\temp\other\visual_studio.iso"
#$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
#$driveLetter = ($rc | Get-Volume).DriveLetter
#$installPath = Join-Path "${driveLetter}:" "vs_community.exe"
#Start-Process -FilePath $installPath -ArgumentList "/adminfile A:\AdminDeployment.xml /quiet /norestart" -NoNewWindow -Wait
#Dismount-DiskImage -ImagePath $isoPath
#Remove-Item -Force -Path $isoPath 

#Write-Host "Installing Resharper..."
#choco install -y resharper-platform
#choco install -y resharper-clt

#Write-Host "Installing the Hide Main Menu VSIX..."
#$vsixInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\VSIXInstaller.exe"
#$extensionPath = "c:\windows\temp\other\HideMenu.vsix"
#Start-Process -FilePath $vsixInstallerPath -ArgumentList "/q $extensionPath" -NoNewWindow -Wait
#Remove-Item -Force -Path $extensionPath

#Write-Host "Configuring Resharper to use the IntelliJ Keyboard Scheme..."
#$dotSettingsSource = "C:\windows\temp\other\vsActionManager.DotSettings"
#$dotSettingsDestination = "C:\Users\vagrant\AppData\Local\JetBrains\ReSharper\vAny\vs12.0"
#New-Item $dotSettingsDestination -Type directory
#Move-Item -Force -Path $dotSettingsSource -Destination $dotSettingsDestination

#Write-Host "Pinning Visual Studio to the TaskBar..."
#$shell = new-object -com "Shell.Application"
#$dir = $shell.Namespace("C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE")
#$item = $dir.ParseName("devenv.exe")
#$item.InvokeVerb('taskbarpin')


#Write-Host "Importing some sensible defaults to Visual Studio and killing the first run wizard..."
#$settingsPath = "C:\windows\temp\other\Sane.vssettings"
#$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
#$process = Start-Process -FilePath $devenvPath -ArgumentList "/ResetSettings $settingsPath /Command File.Exit" -NoNewWindow -PassThru
##If this doesn't complete in 1 minute, then seriously, WTF?
#if ( ! $process.WaitForExit(60000) ) {
    #$process.Kill()
#}
#Remove-Item -Force -Path $settingsPath

#Write-Host "FIXING THE ALL CAPS MENU IN VISUAL STUDIO..."
#Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1

#Write-Host "Fixing the Visual Studio Start Screen..."
#New-ItemProperty -Force -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General -Name OnEnvironmentStartup -Type DWord -Value 4
#New-Item -Force -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General\StartPage
#New-ItemProperty -Force -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General\StartPage -Name IsDownloadRefreshEnabled -Type DWord -Value 0
#New-ItemProperty -Force -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General\StartPage -Name OptIn -Type DWord -Value 0


