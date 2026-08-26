@echo off
title Among Us Modpack - Online Setup ^& Updater
color 0A

echo ========================================================
echo     Among Us Modpack Setup ^& Updater (Town of Us)
echo ========================================================
echo.

:: ==========================================================
:: CONFIGURATION (Set your GitHub Username & Repository Name)
:: ==========================================================
set "GITHUB_USER=orrjoshuac"
set "GITHUB_REPO=AmongUsModpack"

set "STEAM_GAME=C:\Program Files (x86)\Steam\steamapps\common\Among Us"
set "TARGET_DIR=%LOCALAPPDATA%\Among Us Modded"
set "ZIP_URL=https://github.com/%GITHUB_USER%/%GITHUB_REPO%/archive/refs/heads/main.zip"
set "TEMP_ZIP=%TEMP%\repo_update.zip"
set "TEMP_EXTRACT=%TEMP%\repo_extract"

:: 1. Check for Base Game Installation
if not exist "%STEAM_GAME%\Among Us.exe" (
    echo [!] ERROR: Could not find base Among Us at standard Steam path:
    echo     "%STEAM_GAME%"
    echo.
    echo Please make sure Among Us is installed via Steam on your C: drive.
    echo.
    pause
    exit
)

:: 2. Smart Copy Base Game (Only runs on first launch)
if exist "%TARGET_DIR%\Among Us.exe" (
    echo [*] Modded base game located in AppData. Preparing update...
) else (
    echo [+] First-time setup detected!
    echo [+] Copying base game from Steam to AppData...
    mkdir "%TARGET_DIR%"
    xcopy "%STEAM_GAME%" "%TARGET_DIR%\" /E /I /H /Y /Q >nul
    echo [+] Base game copied successfully!
    echo.
)

:: 3. Download Latest Mod Repo Archive from GitHub
echo [+] Fetching latest mod files from GitHub...
powershell -NoProfile -ExecutionPolicy Bypass -Command "^
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; ^
    try { ^
        (New-Object System.Net.WebClient).DownloadFile('%ZIP_URL%', '%TEMP_ZIP%'); ^
    } catch { ^
        Write-Host '[!] ERROR: Failed to download update from GitHub.' -ForegroundColor Red; ^
        exit 1; ^
    }"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Please check your internet connection or verify your GitHub repository settings.
    pause
    exit
)

:: 4. Extract Repo and Inject 'ModFiles' Contents Directly into Game Folder
echo [+] Extracting and injecting mod files...
if exist "%TEMP_EXTRACT%" rmdir /s /q "%TEMP_EXTRACT%"

powershell -NoProfile -ExecutionPolicy Bypass -Command "^
    Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath '%TEMP_EXTRACT%' -Force"

set "MOD_SOURCE=%TEMP_EXTRACT%\%GITHUB_REPO%-main\ModFiles"

if exist "%MOD_SOURCE%" (
    xcopy "%MOD_SOURCE%\*" "%TARGET_DIR%\" /E /I /H /Y /Q >nul
    echo [+] Mod files updated successfully!
) else (
    echo [!] ERROR: Could not locate 'ModFiles' directory in the repository archive.
    echo     Ensure the 'ModFiles' folder exists at the root of your GitHub repo.
)

:: Clean up temporary installer files
del "%TEMP_ZIP%" >nul 2>&1
rmdir /s /q "%TEMP_EXTRACT%" >nul 2>&1

echo.

:: 5. Create / Refresh Desktop Shortcut
echo [+] Refreshing Desktop Shortcut...
set "VBS_SCRIPT=%TEMP%\CreateShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo sLinkFile = "%USERPROFILE%\Desktop\Among Us (Modded).lnk" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "%TARGET_DIR%\Among Us.exe" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "%TARGET_DIR%" >> "%VBS_SCRIPT%"
echo oLink.Description = "Play Modded Among Us" >> "%VBS_SCRIPT%"
echo oLink.Save >> "%VBS_SCRIPT%"
cscript //nologo "%VBS_SCRIPT%"
del "%VBS_SCRIPT%"

echo.
echo ========================================================
echo  SETUP / UPDATE COMPLETE!
echo  Launch the game using the 'Among Us (Modded)' desktop icon.
echo ========================================================
echo.
pause