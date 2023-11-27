Do you want to build in peace without monsters attacking you??  This mod adds peaceful mode, meaning all monsters will not attack you and will ignore you.

The initial mod provides
1. Toggle peaceful mode(Press Shift-T)
2. Ability to remap keys (see below)

How to install
1. Unzip the zip file
2. Copy all the files to ReturnToMoria\Moria\Binaries\Win64 (i.e. C:\Program Files\Epic Games\ReturnToMoria\Moria\Binaries\Win64 )
3. Run the game

Youtube video demo
Coming Soon!

Youtube video to install
https://www.youtube.com/watch?v=HZ2adE99Q6E


How to uninstall all mods
Delete the mods directory
Delete the UE4SS_Signatures directory
Delete xinput1_3.dll, UE4SS0settings.ini, README.txt, and LICENSE

Keys
Shift-T - Toggle peaceful mode

How to change the keys
1. Open up the Return to Moria directory where you installed the files (i.e. C:\Program Files\Epic Games\ReturnToMoria\Moria\Binaries\Win64 )
2. Go to Mod/BD_HudToggle
3. Open up config.lua with notepad or your preferred editor
4. Edit the line(:
    ["TogglePeacefulMode"]            = {["Key"] = Key.T,             ["ModifierKeys"] = {ModifierKey.SHIFT}},

If you want to change it to "9"
    ["TogglePeacefulMode"]            = {["Key"] = Key.NINE,             ["ModifierKeys"] = {}},

Note if you want to use the number pad instead, it would be Key.NUM_NINE

FAQ
I have multiple BD Mods but I get a warning there are files with the same name, what should I do?
The mods use the same base modding engine, so you can safely click replace the file in the destination

Will this work on a hosted world / server?
Only if the host has the mod installed and enables it will peaceful mode be available.

Is there any known bugs?
Don't press the peaceful mode button as fast as you can, you may crash the game.  If you find an issue, report it to dan@bestdaniel.net

