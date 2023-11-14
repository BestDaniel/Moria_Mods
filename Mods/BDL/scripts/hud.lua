--[[
MIT License

Copyright (c) 2023 BestDaniel.net

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

require("chat_interface")
require("player_interface")

hudVisible = true
hudCharacterVisible = false -- For some reason this must start off as false
hudCombatVisible = false


function ToggleUserHud()
    UIManager = FindFirstOf("FGKUIManager")
    HudVisibleFlag = 0

    if not hudVisible
    then
        HudVisibleFlag = 3
        hudVisible = true
    else
        hudVisible = false -- hiding the HUD
    end

    -- Check if got the HUD...if not....silently fail
    if UIManager:IsValid()
    then
        UIManager:SetHudVisibility(HudVisibleFlag)
    end
end

function ToggleCharacterVisible()
    PlayerController = FindFirstOf("PlayerController")

    VisibleFlag = false

    if not hudCharacterVisible
    then
        VisibleFlag = true
        hudCharacterVisible = true
    else
        hudCharacterVisible = false -- hiding the character
    end

    -- Check if got the HUD...if not....silently fail
    if PlayerController:IsValid()
    then
        PlayerController:SetCinematicMode(hudCharacterVisible, VisibleFlag, true, true, true)
    end
end



function ToggleUserMarkerHud()
    
    hudCombatVisible = 0
    PlayerController = FindFirstOf("BP_WaypointsManager_C")
    PlayerController2 = FindFirstOf("PlayerController")
    PlayerController2:ServerPause()
  
    MoriaHud = FindAllOf("WBP_MoriaHUD_C")



    for Index,ref in pairs(MoriaHud) do
        print(string.format("MorTutorialDisplay %s..\n", ref))
        print(string.format("MorTutorialDisplay %s..\n", ref:GetFullName()))
        ref:ToggleVisibility()
        break
    end

    local PlayerRef = PlayerMainInit()

    if not hudCombatVisible
    then
        HudVisibleFlag = 3
        hudCombatVisible = true
    else
        hudCombatVisible = false -- hiding the HUD
    end

    if PlayerController:IsValid()
    then
        PlayerController['Toggle Visibility']()
        --PlayerController:EnableCheats()
    end

    if DebugMenu:IsValid()
    then
        print("Toggle Invisbility")
    end

    -- Check if got the HUD...if not....silently fail
    if PlayerRef:IsValid()
    then

			print(string.format("MorTutorialDisplay2 %s..\n", PlayerRef.WaypointSpawner))
			print(string.format("MorTutorialDisplay2 %f..\n",  PlayerRef.MorOverheadIndicator:GetWindowVisiblility()))
            PlayerRef.MorOverheadIndicator:SetWindowVisibility(0)
            --UIManager.UnderlayHuds[0]:Hide();

        --UIManager:SetHudVisibility(HudVisibleFlag)
    end
end