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

hudVisible = true
hudCharacterVisible = true
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
        PlayerController:SetCinematicMode(hudCharacterVisible, VisibleFlag, false, false, false)
    end
end

function ToggleUserCombatHud()
    UIManager = FindFirstOf("FGKUIManager")
    hudCombatVisible = 0

    if not hudCombatVisible
    then
        HudVisibleFlag = 3
        hudCombatVisible = true
    else
        hudCombatVisible = false -- hiding the HUD
    end

    -- Check if got the HUD...if not....silently fail
    if UIManager:IsValid()
    then

			print(string.format("MorTutorialDisplay2 %s..\n", UIManager))
			print(string.format("MorTutorialDisplay2 %s..\n", UIManager:GetFullName()))
			print(string.format("MorTutorialDisplay2 %s..\n", UIManager.OverlayHuds[0]))
--			print(string.format("MorTutorialDisplay2 %s..\n", UIManager.UnderlayHuds[0]))
--            print(string.format("MorTutorialDisplay2 %s..\n", UIManager.OverlayHuds[0]:GetFullName()))
			print(string.format("MorTutorialDisplay2 %s..\n", UIManager.UnderlayHuds[0]:Get():GetFullName()))
            --UIManager.UnderlayHuds[0]:Hide();

        --UIManager:SetHudVisibility(HudVisibleFlag)
    end
end