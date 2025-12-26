@echo off
setlocal enabledelayedexpansion
set "username=%USERNAME%"
echo Current user is: %username%

echo [+] Applying Dark Theme...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

curl -s -L -o C:\Users\Public\Desktop\Telegram.exe https://telegram.org/dl/desktop/win64
curl -s -L -o C:\Users\Public\Desktop\7zip.exe https://www.7-zip.org/a/7z2501-x64.exe

echo [+] Downloading Brave Browser...
curl -s -L -o C:\Users\Public\Desktop\BraveSetup.exe https://laptop-updates.brave.com/latest/winx64

powershell -Command "Invoke-WebRequest 'https://github.com/chieunhatnang/VM-QuickConfig/releases/download/1.6.1/VMQuickConfig.exe' -OutFile 'C:\Users\Public\Desktop\VMQuickConfig.exe'"

echo [+] Installing applications...
C:\Users\Public\Desktop\Telegram.exe /VERYSILENT /NORESTART
C:\Users\Public\Desktop\7zip.exe /S
start /wait "" "C:\Users\Public\Desktop\BraveSetup.exe" --silent --install

echo [+] Cleaning up...
del /f "C:\Users\Public\Desktop\Telegram.exe"
del /f "C:\Users\Public\Desktop\7zip.exe"
del /f "C:\Users\Public\Desktop\BraveSetup.exe"
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk"
del /f "C:\Users\Public\Desktop\Unity Hub.lnk"

echo [✓] Setup completed successfully!
pause
