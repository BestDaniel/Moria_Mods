RegisterConsoleCommandHandler("player", function(FullCommand, Parameters)
	if #Parameters < 1 then return false end
--ProcessConsoleExec
--get prints out the health
--set sets the health
	return true
end)


--help command

RegisterConsoleCommandHandler("help", function(FullCommand, Parameters)
	if #Parameters < 1 then return false end
--ProcessConsoleExec
--get prints out the health
--set sets the health
	return true
end)

ConsoleRegisterInit()
RegisterHook("/Script/Moria.MorChatManager:ServerChat", function(Context, MessageParam)
	MessageContent = MessageParam:get():ToString()

	local Playerid, PlayerName, Command, Parameters = MessageContent:match("<(p[0-9]+)>([%w]+)</>%s+>%s+/([%w]+)%s*([%w%s]*)")

	if string.len(Command) > 0
	then
		log.debug("Executing command...")
		NewCommand = Command .. " " .. Playerid .. " " .. PlayerName .. " " .. Parameters
		-- this SHOULD be calling ProcessConsoleExec or equivalent.... then the following code could be used
		--RegisterConsoleCommandHandler("player", function(FullCommand, Parameters)
		--  return true
		-- end)
		ChatHandleCommand(NewCommand)
	end
end)

function ChatHandleCommand(FullCommand)
	--strip out the command, player id, playername, parameters
	--in theory, validate the player ID / playername is AUTHORIZED to execute the command
	
		local Command, Playerid, PlayerName, Parameters = FullCommand:match("([%w]+)%s+(p[0-9]+)%s+([%w]+)%s*([%w%s]*)")
	
		log.info(string.format("Chat3: %s %s %s %s" , PlayerName, Command, Playerid, Parameters))
	
		
	
	
	end


	--[[
RegisterKeyBind(Key.F9, function()
    ExecuteInGameThread(function()  

	print("Key pressed, running code")


	mainPlayerReference = FindAllOf("BP_FGKDwarf_C")
	for Index,Controller in pairs(mainPlayerReference) do
		print(string.format("BP_FGKDwarf_C %s..\n", Controller:GetFullName()))
		print(string.format("Character Name: %s\n", PlayerGetName(Controller)))

		log.debug(string.format("Is dead: " .. tostring(Controller.bIsDead)))


log.debug(string.format("Current health %f..\n",PlayerGetHealth(Controller)))
log.debug(string.format("Current GetStamina %f..\n",PlayerGetStamina(Controller)))
log.debug(string.format("GetMaxHealth %f..\n",PlayerGetMaxHealth(Controller)))
log.debug(string.format("GetMaxStamina %f..\n",PlayerGetMaxStamina(Controller)))
log.debug(string.format("GetArmor %f..\n",PlayerGetArmor(Controller)))
	end
		-- get minimap manager
		MainPlayerReference = FindFirstOf("BP_MinimapManager_C")
		print(string.format("mainPlayerReference %s.." .. tostring(MainPlayerReference.bHidden) .. "\n", MainPlayerReference:GetFullName()))

		--mainPlayerReference:SetActorHiddenInGame(true)
		MainPlayerReference.bHidden = false

		Ref = FindAllOf("MorTutorialDisplay")
		for Index,Controller in pairs(Ref) do
			print(string.format("MorTutorialDisplay %s..\n", Controller))
			print(string.format("MorTutorialDisplay %s..\n", Controller:GetFullName()))
			Controller:Hide()
		end
		--UI_WBP_HUD_StaminaBar2_C /Engine/Transient.GameEngine_2147482603:BP_MoriaGameInstance_C_2147482589.UI_WBP_StaminaBar_Overlay_C_2147479893.WidgetTree.UI_WBP_HUD_StaminaBar2
		Ref = FindAllOf("UI_WBP_HUD_StaminaBar2_C")
		for Index,Controller in pairs(Ref) do
			print(string.format("UI_WBP_HUD_StaminaBar2_C %i %s..\n", Index, Controller.currentStamina))
			print(string.format("UI_WBP_HUD_StaminaBar2_C %s..\n", Controller:GetFullName()))
			print(string.format("UI_WBP_HUD_StaminaBar2_C %s..\n", Controller:GetDebugText()))
			--Ref:BP_PopMessageOnClient("Hello", "title?", 10)

if Index == 3 then

	
end
		end

		Ref = FindAllOf("MorUIManager")
		for Index,Controller in pairs(Ref) do
			print(string.format("MorTutorialDisplay2 %s..\n", Controller))
			print(string.format("MorTutorialDisplay2 %s..\n", Controller:GetFullName()))
			print(string.format("MorTutorialDisplay2 %s..\n", Controller.OverlayHuds[0]))

			--print(string.format("MorTutorialDisplay2 %i..\n", Controller.OverlayHuds:Len()))
			if not toggleHuds then
				
			huds = Controller.OverlayHuds;

			Controller.OverlayHuds:ForEach(function(Index, Element)
				-- Since the inner type of the GeneratedCodes array is 'int', no need to do further processing, just get().
				print(string.format("[%s] %s", Index, Element:get()))
			end)
			--Controller:RemoveHuds();
			--Controller.SetHudVisibility(0)
			toggleHuds = true
		else
			--Controller.SetHudVisibility(3)
		end

		end
--		print(string.format("MorTutorialDisplay %s..\n", Ref))
--		Ref:Hide();

    end)
end)





function Init()
	
	print("Best Daniel Initialization started, finding all game references\n")
	InitLogger("trace", nil) -- info for less verbose
	ChatInit()

	ChatSendLocal(string.format("Best Daniel Mod Initializing, Version: %s..", version))

	ChatLoggerInit()

	local PlayerRef = PlayerMainInit()
	local ActorAttributesRef = PlayerGetActorAttributesRef()

log.debug(string.format("Character Name: %s\n", PlayerGetName(PlayerRef)))
log.debug(string.format("Is dead: " .. tostring(PlayerRef.bIsDead)))


log.debug(string.format("Current health %f..\n",PlayerGetHealth(PlayerRef)))
log.debug(string.format("Current GetStamina %f..\n",PlayerGetStamina(PlayerRef)))
log.debug(string.format("GetMaxHealth %f..\n",PlayerGetMaxHealth(PlayerRef)))
log.debug(string.format("GetMaxStamina %f..\n",PlayerGetMaxStamina(PlayerRef)))
log.debug(string.format("GetArmor %f..\n",PlayerGetArmor(PlayerRef)))

-- Mess with the main player's attributes

log.debug(string.format("GetArmor %f..\n",PlayerRef.AttributeSet.Food.CurrentValue))
log.debug(string.format("GetArmor %f..\n",PlayerRef.AttributeSet.Food.BaseValue))

--Change the players health / HP
PlayerRef.AttributeSet.Health.BaseValue = 50

--full heal player
--PlayerRef.AttributeSet.Health.BaseValue = PlayerGetMaxHealth(PlayerRef)

--Change the player's food / hunger level
PlayerRef.AttributeSet.Food.BaseValue = 50


end
]]

