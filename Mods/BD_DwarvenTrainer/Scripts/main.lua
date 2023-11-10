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
package.path = package.path .. ";Mods\\BDL\\scripts\\?.luaMods\\BD_DwarvenTrainer\\?.lua" -- DO NOT REMOVE, required to include the BDL

require("chat_interface")
require("chat_file_logger")
require("player_interface")
require("logger_init")

version = "0.1"
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


RegisterKey(Keybinds, "FeedDwarf", function()
    ExecuteInGameThread(function()
        if not ChatIsChatWindowActive()
        then
    		PrintIntro()
			PlayerSetFood(PlayerMainInit(), 100)
        end
    end)
end)


RegisterKey(Keybinds, "HealDwarf", function()
    ExecuteInGameThread(function()
        if not ChatIsChatWindowActive()
        then
    		PrintIntro()
			PlayerSetHealth(PlayerMainInit(), 100)
        end
    end)
end)


RegisterKey(Keybinds, "ListDwarves", function()
    ExecuteInGameThread(function()  
		if not ChatIsChatWindowActive()
        then
			ChatSendServer("Players currently online:")
			local Players = PlayerGetAllPlayersRef()
			for Index,Player in pairs(Players) do
				ChatSendServer(string.format("Player: %s - %i health", PlayerGetName(Player), PlayerGetHealth(Player)))
			end
		end
    end)
end)

RegisterKey(Keybinds, "DwarfStats", function()
    ExecuteInGameThread(function()  
		if not ChatIsChatWindowActive()
        then
			PrintIntro()
			local PlayerRef = PlayerMainInit()
			
			ChatSendServer(string.format("Character Name: %s", PlayerGetName(PlayerRef)))
			ChatSendServer(string.format("Is dead: " .. tostring(PlayerRef.bIsDead)))

			ChatSendServer(string.format("Current health %i..",PlayerGetHealth(PlayerRef)))
			ChatSendServer(string.format("Current Armor %i..",PlayerGetArmor(PlayerRef)))
			ChatSendServer(string.format("Current Stamina %i..",PlayerGetStamina(PlayerRef)))
			ChatSendServer(string.format("Max Health %i..",PlayerGetMaxHealth(PlayerRef)))
			ChatSendServer(string.format("Max Stamina %i..",PlayerGetMaxStamina(PlayerRef)))
		end
    end)
end)
