========================================================================
       MODDED AMONG US (TOWN OF US) - QUICK SETUP & UPDATER
========================================================================

This file and script will automatically set up or update a standalone, 
modded copy of Among Us on your PC. You do not need to manually move 
files or configure mod loaders.

------------------------------------------------------------------------
[1] FIRST-TIME SETUP INSTRUCTIONS
------------------------------------------------------------------------

1. UNZIP THIS FOLDER FIRST
   - If this folder is already unzipped, skip this step.
   - Do NOT run the script from inside the zip file!
   - Right-click the downloaded zip file and choose "Extract All...".
   - Extract it anywhere on your PC (like your Downloads folder).

2. RUN THE INSTALLER
   - Open the newly extracted folder.
   - Double-click "installer.bat".
   - The script will locate your base Among Us game from Steam, copy it 
     to AppData, inject the mod files, and place an "Among Us (Modded)" 
     shortcut directly on your Desktop.

3. LAUNCH THE GAME
   - Double-click the "Among Us (Modded)" shortcut on your Desktop!
   - NOTE: The very first load can take 1 to 2 minutes while the mod 
     framework initializes. This is completely normal.

------------------------------------------------------------------------
[2] UPDATING THE MODS (FUTURE RELEASES)
------------------------------------------------------------------------

Whenever new mod updates, custom roles, or config changes are released:
1. Download and extract the newest version of this folder.
2. Double-click "Install_Or_Update_Modpack.bat".
3. The script will detect your existing modded game folder, update the 
   mod files in about 2 seconds, and refresh your Desktop shortcut.

------------------------------------------------------------------------
[3] IMPORTANT FILE & GAME INFORMATION
------------------------------------------------------------------------

- VANILLA GAME SAFETY:
  This script creates an isolated copy of the game inside AppData\Local. 
  Your official Steam installation of Among Us is left 100% untouched, 
  so you can still play normal/unmodded lobbies anytime through Steam.

- REQUIREMENTS:
  You must own and have Among Us installed on your main C: drive via 
  Steam for the script to find and copy the base game files.

- FILE STRUCTURE:
  Do not delete, move, or rename the "ModFiles" folder sitting next to 
  "Install_Or_Update_Modpack.bat". It contains all the necessary mod 
  components used for installation and updates.
========================================================================