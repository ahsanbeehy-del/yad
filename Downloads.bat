@echo off
REM ============================================
REM System Setup and Software Installation Script
REM ============================================

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

REM Set variables
set "username=%USERNAME%"
set "tempDir=C:\Windows\Temp\InstallPackages"
set "desktopPath=C:\Users\Public\Desktop"

echo ============================================
echo System Setup Script
echo Current user: %username%
echo ============================================

REM Create temporary directory
if not exist "%tempDir%" (
    mkdir "%tempDir%"
    echo Created temporary directory: %tempDir%
)

REM ============================================
REM 1. Download and Install Telegram
REM ============================================
echo.
echo [1] Downloading Telegram...
curl -s -L -o "%tempDir%\TelegramSetup.exe" https://telegram.org/dl/desktop/win64
if exist "%tempDir%\TelegramSetup.exe" (
    echo Installing Telegram silently...
    start /wait "" "%tempDir%\TelegramSetup.exe" /VERYSILENT /NORESTART
    echo Telegram installation completed.
    del "%tempDir%\TelegramSetup.exe"
) else (
    echo [WARNING] Failed to download Telegram
)

REM ============================================
REM 2. Download and Install 7-Zip
REM ============================================
echo.
echo [2] Downloading 7-Zip...
curl -s -L -o "%tempDir%\7zipSetup.exe" https://www.7-zip.org/a/7z2501-x64.exe
if exist "%tempDir%\7zipSetup.exe" (
    echo Installing 7-Zip...
    start /wait "" "%tempDir%\7zipSetup.exe" /S
    echo 7-Zip installation completed.
    del "%tempDir%\7zipSetup.exe"
) else (
    echo [WARNING] Failed to download 7-Zip
)

REM ============================================
REM 3. Download VM Quick Config Tool
REM ============================================
echo.
echo [3] Downloading VM Quick Config Tool...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/chieunhatnang/VM-QuickConfig/releases/download/1.6.1/VMQuickConfig.exe' -OutFile '%desktopPath%\VMQuickConfig.exe'"
if exist "%desktopPath%\VMQuickConfig.exe" (
    echo VM Quick Config downloaded to Desktop.
) else (
    echo [WARNING] Failed to download VM Quick Config
)

REM ============================================
REM 4. Clean Up Unwanted Desktop Shortcuts
REM ============================================
echo.
echo [4] Cleaning up desktop shortcuts...
if exist "%desktopPath%\Epic Games Launcher.lnk" (
    del "%desktopPath%\Epic Games Launcher.lnk"
    echo Removed Epic Games Launcher shortcut
)
if exist "%desktopPath%\Unity Hub.lnk" (
    del "%desktopPath%\Unity Hub.lnk"
    echo Removed Unity Hub shortcut
)

REM ============================================
REM 5. Download and Execute Additional Scripts
REM ============================================
echo.
echo [5] Configuring additional settings...

REM Download wallpaper script
echo Downloading wallpaper configuration...
curl -s -L -o "%tempDir%\wallpaper.bat" https://gitlab.com/MR.English2008/mewallpaper/-/raw/main/wall.bat
if exist "%tempDir%\wallpaper.bat" (
    call "%tempDir%\wallpaper.bat"
    echo Wallpaper configured.
    del "%tempDir%\wallpaper.bat"
)

REM Download and run PowerShell message script
echo Downloading system message script...
curl -s -L -o "%tempDir%\message.ps1" https://gitlab.com/MR.English2008/pcme_rdp/-/raw/main/msg.ps1
if exist "%tempDir%\message.ps1" (
    echo Displaying installation message...
    powershell -ExecutionPolicy Bypass -File "%tempDir%\message.ps1" "Please install TikTok, Facebook, Brave Browser, and all required applications"
    del "%tempDir%\message.ps1"
)

REM ============================================
REM 6. Cleanup and Completion
REM ============================================
echo.
echo [6] Finalizing installation...

REM Remove temporary directory
if exist "%tempDir%" (
    rmdir /s /q "%tempDir%"
    echo Temporary files cleaned up.
)

echo.
echo ============================================
echo INSTALLATION COMPLETED
echo ============================================
echo Please install the following applications manually:
echo 1. TikTok
echo 2. Facebook App
echo 3. Brave Browser
echo 4. Other required applications
echo ============================================
echo.
pause