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
package.path = package.path .. ";Mods\\BDL\\scripts\\?.lua;Mods\\BD_HudToggle\\?.lua" -- DO NOT REMOVE, required to include the BDL

require("chat_interface")
require("chat_file_logger")
require("player_interface")
require("logger_init")
require("hud")
require("config")
require("keybinding")
require("game")

version = "0.3"
introMessage = "Best Daniel mod, version: ".. version .. "\nLearn more at: \nhttps://www.youtube.com/@bestdanielnet\n https://bestdaniel.net"
isIntroPrinted = false

function PrintIntro()
	if isIntroPrinted == false
	then
		ChatSendServer(introMessage)
		isIntroPrinted = true
	end
end


-- ##############################
-- Hook on load / reload
-- ##############################

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context, NewPawn)

end)


-- ##############################
-- Trigger by Key press
-- ##############################

RegisterKey(Keybinds, "HideHUD", function()
    ExecuteInGameThread(function()
        if not ChatIsChatWindowActive()
        then
    		PrintIntro()
            ToggleUserHud()
        end
    end)
end)

RegisterKey(Keybinds, "HideDwarf", function()
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            ToggleCharacterVisible()
        end
    end)
end)