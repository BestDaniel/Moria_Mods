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
    mainPlayerReference = FindFirstOf("BP_FGKDwarf_C")
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


function PlayerGetActorAttributesRef()
    return actorAttributesRef
end

function PlayerGetName(PlayerRef)
    return PlayerRef:GetCharacterName():ToString()
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

function PlayerGetArmor(PlayerRef)
    return actorAttributesRef:GetArmor(PlayerRef)
end

function PlayerSetHealth(Playername, value)
    PlayerRef = PlayerGetMainRef()
    PlayerRef.AttributeSet.Health.BaseValue = value
end

function PlayerSetFood(Playername, value)
    PlayerRef = PlayerGetMainRef()
    PlayerRef.AttributeSet.Food.BaseValue = value
end

function PlayerGetAllPlayersRef()
    return FindAllOf("BP_FGKDwarf_C")
end