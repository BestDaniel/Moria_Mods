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
package.path = package.path .. ";Mods\\BDL\\scripts\\?.lua" -- DO NOT REMOVE, required to include the BDL
package.path = package.path .. ";Mods\\BD_DwarvenTrainer\\?.lua" -- DO NOT REMOVE, required to include key configuration file

require("chat_interface")
require("chat_file_logger")
require("player_interface")
require("logger_init")
require("config") -- defines keys to bind to for mod
require("keybinding")

version = "0.2"
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
    print("FeedDwarf")
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            PlayerSetFood(PlayerRef, 100) -- 100 is the max food level, I think above this will be ignored by the game?
        end
    end)
end)

RegisterKey(Keybinds, "HealDwarf", function()
    print("HealDwarf")
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            local Max = PlayerGetMaxHealth(PlayerRef)
            PlayerSetHealth(PlayerRef, Max)
        end
    end)
end)

RegisterKey(Keybinds, "GiveDwarfEnergy", function()
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            PlayerSetEnergy(PlayerRef, 100) -- 100 is the max level, I think above this will be ignored by the game?
        end
    end)
end)

RegisterKey(Keybinds, "GiveDwarfStamina", function()
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            PlayerSetStamina(PlayerRef, 100)
        end
    end)
end)

RegisterKey(Keybinds, "ReviveDwarf", function()
    print("ReviveDwarf")
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            PlayerRevive(PlayerRef)
        end
    end)
end)

RegisterKey(Keybinds, "ListDwarves", function()
    ExecuteInGameThread(function()    
		if not ChatIsChatWindowActive()
        then
            PrintIntro()
			ChatSendServer("Players currently online:")
			local Players = PlayerGetAllPlayersRef()
			for Index,Player in pairs(Players) do
				ChatSendServer(string.format("Player: %s - %i health", PlayerGetName(Player), PlayerGetHealth(Player)))
			end
		end
    end)
end)

RegisterKey(Keybinds, "RepairArmor", function()
    print("RepairArmor")
    ExecuteInGameThread(function()  
        if not ChatIsChatWindowActive()
        then
            PrintIntro()
            local PlayerRef = PlayerMainInit()
            local MaxArmor = PlayerGetMaxArmor(PlayerRef)
            print(string.format("RepairArmor %f", MaxArmor))
            PlayerSetArmor(PlayerRef, MaxArmor)
        end
    end)
end)