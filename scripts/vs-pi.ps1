Write-Host "Installing Visual Studio"
$isoPath = "C:\windows\temp\other\en_visual_studio_ultimate_2013_with_update_4_x86_dvd_5935075.iso"
$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
$driveLetter = ($rc | Get-Volume).DriveLetter
$installPath = Join-Path "${driveLetter}:" "vs_ultimate.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile A:\AdminDeployment.xml /quiet /norestart" -NoNewWindow -Wait
Dismount-DiskImage -ImagePath $isoPath
Remove-Item -Force -Path $isoPath 
