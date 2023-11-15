This mod allows you to control your camera, such as zooming in and out!

The mod provides:
1. Zoom IN(Press +)
2. Zoom OUT(Press -)

How to install
1. Unzip the zip file
2. Copy all the files to ReturnToMoria\Moria\Binaries\Win64 (i.e. C:\Program Files\Epic Games\ReturnToMoria\Moria\Binaries\Win64 )
3. Run the game

Youtube video to install
https://www.youtube.com/watch?v=HZ2adE99Q6E

How to uninstall
Delete the mods directory
Delete the UE4SS_Signatures directory
Delete xinput1_3.dll, UE4SS0settings.ini, README.txt, and LICENSE

Keys
+ : Zooms in on the character
- : Zooms out on the character


How to change the keys
1. Open up the Return to Moria directory where you installed the files (i.e. C:\Program Files\Epic Games\ReturnToMoria\Moria\Binaries\Win64 )
2. Go to Mod/BD_HudToggle
3. Open up config.lua with notepad or your preferred editor
4. Edit the line(:
["ZoomIN"]                 = {["Key"] = Key.ADD,             ["ModifierKeys"] = {}},

If you want to change it to "9"
["ZoomIN"]                 = {["Key"] = Key.NINE,             ["ModifierKeys"] = {}},

FAQ

I have multiple BD Mods but I get a warning there are files with the same name, what should I do?
The mods use the same base modding engine, so you can safely click replace the file in the destination

When my character is hidden, I still see my torch or weapon!
You need to deselect your torch and weapon then you'll be completely hidden from the screenshot.

Is there any known bugs?
None at this time but if you find one let me know! dan@bestdaniel.net