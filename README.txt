========================================================================
        MODDED AMONG US (TOWN OF US) - QUICK SETUP & UPDATER
========================================================================

This script will automatically set up or update a standalone, modded copy 
of Among Us on your PC. You do not need to manually move files or 
configure mod loaders.

------------------------------------------------------------------------
[1] FIRST-TIME SETUP INSTRUCTIONS
------------------------------------------------------------------------

1. RUN THE INSTALLER
   - Double-click "installer.bat".
   - The script will locate your base Among Us game from Steam, copy it 
     to AppData, sync the latest mod files directly from GitHub, and 
     place an "Among Us (Modded)" shortcut on your Desktop.

2. LAUNCH THE GAME
   - The game will launch automatically when the script finishes.
   - For future play sessions, double-click the "Among Us (Modded)" 
     shortcut on your Desktop!
   - NOTE: The very first load can take 1 to 2 minutes while the mod 
     framework initializes. This is completely normal.

------------------------------------------------------------------------
[2] UPDATING THE MODS (FUTURE RELEASES)
------------------------------------------------------------------------

Whenever new mod updates, custom roles, or config changes are released:
1. Simply double-click the "Among Us (Modded)" shortcut on your Desktop.
2. The shortcut points to the script, which connects to GitHub, syncs 
   any updated mod files in the background, and boots the game.

------------------------------------------------------------------------
[3] IMPORTANT FILE & GAME INFORMATION
------------------------------------------------------------------------

- VANILLA GAME SAFETY:
  This script creates an isolated copy of the game inside AppData\Local. 
  Your official Steam installation of Among Us is left 100% untouched, 
  so you can still play normal/unmodded lobbies anytime through Steam.

- REQUIREMENTS:
  You must own and have Among Us installed on your main C: drive via 
  Steam (C:\Program Files (x86)\Steam\steamapps\common\Among Us) for 
  the script to find and copy the base game files. Runs on Windows 10/11.

- CONFLICT PREVENTION:
  The script automatically closes lingering "Among Us.exe" or 
  "UnityCrashHandler64.exe" processes prior to syncing to prevent 
  file-lock ("Access is Denied") errors during updates.

------------------------------------------------------------------------
[4] HOST / MAINTAINER GUIDE (FOR UPDATING MODS)
------------------------------------------------------------------------

- UPDATING MOD FILES:
  1. Update, add, or replace files inside the ModFiles/ folder in 
     your local repository.
  2. Commit and push the changes to GitHub.
  3. Players will automatically receive the updated files the next time 
     they launch their "Among Us (Modded)" desktop shortcut.

- FORCING A BASE GAME RE-COPY (PATCH DAYS / MAJOR UPDATES):
  When InnerSloth updates the main Among Us base game or a new mod 
  version requires a clean base game copy:
  1. Open installer.bat in a text editor.
  2. Change line 17 to: set "FORCE_RECOPY_BASE=true"
  3. Commit and push the updated script to GitHub.
  4. When players run the script, it will wipe their old AppData folder, 
     re-copy the fresh base game from Steam, and apply the new mod files.
  5. Set FORCE_RECOPY_BASE=false on your next commit once updated.

------------------------------------------------------------------------
[5] TROUBLESHOOTING
------------------------------------------------------------------------

- "Could not find base Among Us at standard Steam path"
  Make sure Among Us is installed through Steam on your primary C: drive.

- "MOD DOWNLOAD FAILED!"
  Check your internet connection. If testing repeatedly, you may have 
  briefly hit GitHub's unauthenticated API rate limit (60 calls/hour). 
  Wait a few minutes and try again.

- Game launches as vanilla / unmodded
  Ensure your mod files are placed inside the ModFiles/ folder on 
  GitHub with exact case-sensitive matching.
========================================================================