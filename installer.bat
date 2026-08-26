@echo off
title Among Us Modpack - Setup ^& Updater
color 0A

echo ========================================================
echo     Among Us Modpack Setup ^& Updater (Town of Us)
echo ========================================================
echo.

:: 1. Define Paths & Subfolder Name
set "STEAM_GAME=C:\Program Files (x86)\Steam\steamapps\common\Among Us"
set "TARGET_DIR=%LOCALAPPDATA%\Among Us Modded"
set "MOD_SOURCE_FOLDER=ModFiles"

:: 2. Check for Base Game Installation
if not exist "%STEAM_GAME%\Among Us.exe" (
    echo [!] ERROR: Could not find base Among Us at standard Steam path:
    echo     "%STEAM_GAME%"
    echo.
    echo Please make sure Among Us is installed via Steam on your C: drive.
    echo.
    pause
    exit
)

:: 3. Check for Mod Source Subfolder
if not exist "%~dp0%MOD_SOURCE_FOLDER%" (
    echo [!] ERROR: Could not find the mod files subfolder: "%MOD_SOURCE_FOLDER%"
    echo     Make sure the folder is named correctly and located next to this script.
    echo.
    pause
    exit
)

:: 4. Smart Copy Base Game (Only runs on fresh install)
if exist "%TARGET_DIR%\Among Us.exe" (
    echo [*] Modded folder already exists in AppData. Skipping base game copy...
    echo.
) else (
    echo [+] Copying 'Among Us' from Steam common to AppData...
    mkdir "%TARGET_DIR%"
    xcopy "%STEAM_GAME%" "%TARGET_DIR%\" /E /I /H /Y /Q >nul
    echo [+] Base game folder copied successfully!
    echo.
)

:: 5. Copy Contents FROM Subfolder DIRECTLY Into Game Directory
echo [+] Injecting mod files from '%MOD_SOURCE_FOLDER%'...
xcopy "%~dp0%MOD_SOURCE_FOLDER%\*" "%TARGET_DIR%\" /E /I /H /Y /Q >nul

echo [+] Mod files updated successfully!
echo.

:: 6. Create / Refresh Desktop Shortcut
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