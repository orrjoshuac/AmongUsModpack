@echo off
title Among Us Modpack - Auto-Updater ^& Launcher
color 0A

echo ========================================================
echo     Among Us Modpack - Auto-Updater ^& Launcher
echo ========================================================
echo.

:: ==========================================================
:: CONFIGURATION (Set your GitHub Username & Repository)
:: ==========================================================
set "GITHUB_USER=orrjoshuac"
set "GITHUB_REPO=AmongUsModpack"

:: Set to 'true' ONLY when the mod updates to a new base game version 
:: and you need to force everyone's AppData base game to re-copy from Steam.
set "FORCE_RECOPY_BASE=false"

set "STEAM_GAME=C:\Program Files (x86)\Steam\steamapps\common\Among Us"
set "TARGET_DIR=%LOCALAPPDATA%\Among Us Modded"
set "ZIP_URL=https://github.com/%GITHUB_USER%/%GITHUB_REPO%/archive/refs/heads/main.zip"
set "TEMP_ZIP=%TEMP%\repo_archive.zip"
set "EXTRACT_TEMP=%TEMP%\repo_extracted"

:: 1. Check for Base Game Installation in Steam
if not exist "%STEAM_GAME%\Among Us.exe" (
    echo [!] ERROR: Could not find base Among Us at standard Steam path:
    echo     "%STEAM_GAME%"
    echo.
    echo Please make sure Among Us is installed via Steam on your C: drive.
    echo.
    pause
    exit
)

:: 2. Handle Base Game Copy / Force Re-copy
if "%FORCE_RECOPY_BASE%"=="true" (
    echo [*] New base game version flag detected. Re-copying base game from Steam...
    if exist "%TARGET_DIR%" rmdir /s /q "%TARGET_DIR%"
)

if exist "%TARGET_DIR%\Among Us.exe" (
    echo [*] Modded base game is ready in AppData.
) else (
    echo [+] Copying 'Among Us' base game from Steam to AppData...
    mkdir "%TARGET_DIR%"
    xcopy "%STEAM_GAME%" "%TARGET_DIR%\" /E /I /H /Y /Q >nul
    echo [+] Base game copied successfully!
    echo.
)

:: 3. Fast Full-Repo Zip Download & Extraction
echo [+] Connecting to GitHub and fast-syncing mod files...
echo.

:: Force-close any running instances to release file locks
taskkill /F /IM "Among Us.exe" >nul 2>&1
taskkill /F /IM "UnityCrashHandler64.exe" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command "$u='%ZIP_URL%'; $z='%TEMP_ZIP%'; $ex='%EXTRACT_TEMP%'; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { if (Test-Path $ex) { Remove-Item -Path $ex -Recurse -Force }; (New-Object System.Net.WebClient).DownloadFile($u, $z); Expand-Archive -Path $z -DestinationPath $ex -Force; Remove-Item -Path $z -Force; exit 0 } catch { Write-Host ('`n[!] ERROR: ' + $_.Exception.Message) -ForegroundColor Red; exit 1 }"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ========================================================
    echo  [!] MOD DOWNLOAD FAILED!
    echo  Check the error message above. Game will NOT launch.
    echo ========================================================
    echo.
    pause
    exit
)

:: Copy extracted ModFiles into game folder using Robocopy (fast & avoids access locks)
set "MOD_SRC=%EXTRACT_TEMP%\%GITHUB_REPO%-main\ModFiles"
if exist "%MOD_SRC%" (
    robocopy "%MOD_SRC%" "%TARGET_DIR%" /E /NJH /NJS /NDL /NC /NS /NP /IS /IT >nul
    rmdir /s /q "%EXTRACT_TEMP%"
    echo [+] Mod files successfully updated!
) else (
    echo [!] ERROR: Could not locate ModFiles directory in repo download.
    pause
    exit
)

echo.

:: 4. Create / Refresh Desktop Shortcut
echo [+] Refreshing Desktop Shortcut...
set "VBS_SCRIPT=%TEMP%\CreateShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo sLinkFile = "%USERPROFILE%\Desktop\Among Us (Modded).lnk" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "%~f0" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "%~dp0" >> "%VBS_SCRIPT%"
echo oLink.IconLocation = "%TARGET_DIR%\Among Us.exe, 0" >> "%VBS_SCRIPT%"
echo oLink.Description = "Play Modded Among Us" >> "%VBS_SCRIPT%"
echo oLink.Save >> "%VBS_SCRIPT%"
cscript //nologo "%VBS_SCRIPT%"
del "%VBS_SCRIPT%"

:: 5. Launch Game and Close Shell Immediately
start "" "%TARGET_DIR%\Among Us.exe"
exit