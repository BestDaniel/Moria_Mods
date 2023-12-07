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

function PlayerMainInit()

    -- Find the local player instead of depending on luck on the order of BP_FGKDwarf_C instances
    local LocalPlayer = FindFirstOf("LocalPlayer")
    if not LocalPlayer:IsValid() then
		error("LocalPlayer's reference not found!!\n")        
    end
    mainPlayerController = LocalPlayer.PlayerController
    if not mainPlayerController:IsValid() then
		error("LocalPlayer's Controller reference not found!!\n")        
    end
 
    mainPlayerReference = mainPlayerController.Character

    if not mainPlayerReference:IsValid() 
	then 
		error("Player's reference not found!!\n")
	end

	actorAttributesRef = FindObject("MorAttributesFunctionLibrary", "", RF_NoFlags, RF_NoFlags)
	if not actorAttributesRef:IsValid() 
	then 
		error("Get Helper class Actor Attributes reference not found!!\n")
	end
	return mainPlayerReference
end

function PlayerGetMainRef()
    return mainPlayerReference
end

function PlayerGetMainControllerRef()
    if not mainPlayerController or not mainPlayerController:IsValid() then
		PlayerMainInit()
    end
    return mainPlayerController
end


function PlayerGetActorAttributesRef()
    return actorAttributesRef
end

function PlayerGetName(PlayerRef)
    return PlayerRef:GetCharacterName(false):ToString()
end

function PlayerGetHealth(PlayerRef)
    return actorAttributesRef:GetHealth(PlayerRef)
end

function PlayerGetMaxHealth(PlayerRef)
    return actorAttributesRef:GetMaxHealth(PlayerRef)
end

function PlayerGetStamina(PlayerRef)
    return actorAttributesRef:GetStamina(PlayerRef)
end

function PlayerGetMaxStamina(PlayerRef)
    return actorAttributesRef:GetMaxStamina(PlayerRef)
end

function PlayerGetTemperature(PlayerRef)
    return actorAttributesRef:GetTemperature(PlayerRef)
end

function PlayerGetMorale(PlayerRef)
    return actorAttributesRef:GetMorale(PlayerRef)
end

function PlayerGetLight(PlayerRef)
    return actorAttributesRef:GetLight(PlayerRef)
end

function PlayerGetEnergy(PlayerRef)
    return actorAttributesRef:GetEnergy(PlayerRef)
end

function PlayerGetArmor(PlayerRef)
    return actorAttributesRef:GetArmor(PlayerRef)
end

function PlayerGetMaxArmor(PlayerRef)
    return actorAttributesRef:GetMaxArmor(PlayerRef)
end

function PlayerGetMaxHealth(PlayerRef)
    return actorAttributesRef:GetMaxHealth(PlayerRef)
end

function PlayerSetHealth(PlayerRef, value)
    PlayerRef.AttributeSet.Health.BaseValue = value
end

function PlayerSetFood(PlayerRef, value)
    PlayerRef.AttributeSet.Food.BaseValue = value
end

function PlayerSetArmor(PlayerRef, value)
    --PlayerRef.AttributeSet.Armor.BaseValue = value
    PlayerRef.AttributeSet.Armor.CurrentValue = value
end

function PlayerSetStamina(PlayerRef, value)
    PlayerRef.AttributeSet.Stamina.BaseValue = value
end

function PlayerSetMorale(PlayerRef, value)
    PlayerRef.AttributeSet.Morale.BaseValue = value
end

function PlayerSetEnergy(PlayerRef, value)
    PlayerRef.AttributeSet.Energy.BaseValue = value
end

function PlayerSetTemperature(PlayerRef, value)
    PlayerRef.AttributeSet.Temperature.BaseValue = value
end

function PlayerSetHealth(PlayerRef, value)
    PlayerRef.AttributeSet.Health.BaseValue = value
end


function PlayerKill(PlayerRef)
    PlayerRef:SetIsDead(true)
    PlayerRef:Die(true)
    --HealthComp:SeSetIsDeadrver_Kill()
end

function PlayerRevive(PlayerRef)
    PlayerRef:ServerRevive()
end

function PlayerSetTeam(PlayerRef, TeamNumber)
    PlayerRef:SetTeam(TeamNumber)
end

function PlayerGetAllPlayersRef()
    return FindAllOf("BP_FGKDwarf_C")
end

function PlayerTotalPlayers()
    local Players = FindAllOf("BP_FGKDwarf_C")
    local PlayerCount = 0
    if Players ~= nil then
        PlayerCount = #Players
    end
    return PlayerCount
end

function PlayerGetPlayerByName(PlayerName)

    local LowerPlayerName = PlayerName:lower()

    local Players = PlayerGetAllPlayersRef()
    for Index,PlayerRef in pairs(Players) do
        local CurrentPlayerName = PlayerGetName(PlayerRef)
        CurrentPlayerName = CurrentPlayerName:lower()
        if(CurrentPlayerName == LowerPlayerName) then
            return PlayerRef
        end
    end
    return nil
end


function PlayerIsPlayerServerOwner(PlayerName)
    local ServerPlayerRef = PlayerMainInit()
    local ServerPlayerName = string.lower(PlayerGetName(ServerPlayerRef))
    if ServerPlayerName == PlayerName then
        return true
    end
    return false;
end