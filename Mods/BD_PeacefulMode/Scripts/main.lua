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
package.path = package.path .. ";Mods\\BD_PeacefulMode\\?.lua" -- DO NOT REMOVE, required to include key configuration file

require("chat_interface")
require("player_interface")
require("logger_init")
require("config") -- defines keys to bind to for mod
require("keybinding")
require("ui")

local ChatColor = require("chat_color")

version = "0.1"
introMessage = ChatColor.ORANGE .. "Best Daniel mod".. ChatColor.ENDCOLOR .." version: ".. version .. "\n"
learnmoreMessage = ChatColor.BLUE .."Learn more at:"  .. ChatColor.ENDCOLOR .. "\nhttps://bestdaniel.net"
isIntroPrinted = false
isGamePeacefulModeEnabled = false
defaultTeam = 200 --high enough that a new monster team shouldn't end up using the same team!

function PrintIntro()
	if isIntroPrinted == false
	then
		ChatSendServer(introMessage)
		ChatSendServer(learnmoreMessage)
		isIntroPrinted = true
	end
end

-- ##############################
-- Hook on load / reload
-- ##############################

function RegisterPlayerJoinedHook()
    
    NotifyOnNewObject("/Game/Character/Dwarf/BP_FGKDwarf.BP_FGKDwarf_C", function(self)
        print("New Character joined, setting team mode")
        ExecuteWithDelay(10000,SetAllPlayersMode) -- delayed as character joining doesn't show up for a short period, not sure what happens if set their team too early
    end)
end

-- ##############################
-- Trigger by Key press
-- ##############################
RegisterKey(Keybinds, "TogglePeacefulMode", function()

    local PlayerCount = PlayerTotalPlayers()

    -- Check if player is in the game / has chat window active or editing a mapstone name, if so, ignore the key press!
    if PlayerCount == 0 or ChatIsChatWindowActive() or  IsPlayerEditingMapstoneName() 
    then
        return
    end

        PrintIntro()
        
        RegisterPlayerJoinedHook()

        if(isGamePeacefulModeEnabled)
        then
            ChatSendServer(ChatColor.ORANGE .. "Peaceful Mode Disabled" .. ChatColor.ENDCOLOR)
        else
            ChatSendServer(ChatColor.GREEN .. "Peaceful Mode Activated" .. ChatColor.ENDCOLOR)

        end
    
        isGamePeacefulModeEnabled = not isGamePeacefulModeEnabled

        SetAllPlayersMode()

end)

function SetAllPlayersMode()
    local NewTeam = 0
    if(isGamePeacefulModeEnabled)
    then
        NewTeam = defaultTeam
    end
    SetAllPlayersTeam(NewTeam)
end

function SetAllPlayersTeam(Team)
    local AllPlyayers = PlayerGetAllPlayersRef()
   
    for Index,Player in pairs(AllPlyayers) do
        PlayerSetTeam(Player, Team)
        print(string.format("Player %s is assigned team %f",  PlayerGetName(Player), Player.Team))
    end
end
