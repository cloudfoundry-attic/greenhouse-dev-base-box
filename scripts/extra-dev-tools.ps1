Write-Host "Installing Resharper..."
Start-Process -FilePath C:\windows\temp\other\ReSharper.exe -ArgumentList "/SpecificProductNames=ReSharper;dotTrace;dotCover;dotPeek /Silent=True /VsVersion=12" -Wait -NoNewWindow

Write-Host "Installing Resharper Command Line Tools..."
choco install -y resharper-clt

Write-Host "Configuring Resharper to use the IntelliJ Keyboard Scheme..."
$dotSettingsSource = "C:\windows\temp\config\vsActionManager.DotSettings"
$dotSettingsDestination = "C:\Users\vagrant\AppData\Local\JetBrains\ReSharper\vAny\vs12.0"
New-Item $dotSettingsDestination -Type directory
Move-Item -Force -Path $dotSettingsSource -Destination $dotSettingsDestination

Write-Host "Pinning Visual Studio to the TaskBar..."
$shell = new-object -com "Shell.Application"
$dir = $shell.Namespace("C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE")
$item = $dir.ParseName("devenv.exe")
$item.InvokeVerb('taskbarpin')

Write-Host "FIXING THE ALL CAPS MENU IN VISUAL STUDIO..."
Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1
