Write-Host "Installing Visual Studio"
$installPath = Join-Path "E:" "vs_ultimate.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile A:\AdminDeployment.xml /quiet /norestart" -NoNewWindow -Wait
