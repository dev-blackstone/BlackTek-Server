dofile('data/lib/custom/modal_windows_config.lua')

function Player.sendModalWindow(self, title)
	local modalConfig = MODAL_WINDOW_CONFIG[title]
	if not modalConfig then
		return self:sendCancelMessage("Modal Configuration '" .. title .. "' was not found.")
	end
	local function baseCallback(player, button, choice)
		local buttonConfig = modalConfig.buttons[button.id]
		if not buttonConfig then
			return player:sendCancelMessage("Button Configuration '" .. button.name .. "' was not found.")
		end
		local choiceConfig = modalConfig.choices[choice.id]
		if not choiceConfig then
			return player:sendCancelMessage("Choice Configuration '" .. choice.text .. "' was not found.")
		end
		local success, errorMessage = true, nil
		if buttonConfig.confirmCheck then
			success, errorMessage = buttonConfig.confirmCheck(player, choice)
		end 
		if success then
			return buttonConfig.callback(player, button, choice)
		elseif errorMessage then
			return player:sendCancelMessage(errorMessage)
		end
		return false
	end
	local window = ModalWindow {title=title, message=modalConfig.message and modalConfig.message .. "\n\n" or ""}
	for index, options in pairs(modalConfig.buttons) do
		if not options.checkVisibility or options.checkVisibility(self) then
			window:addButton(options.label, baseCallback, index)
			if options.enterButton then
				window:setDefaultEnterButton(label)
			end
			if options.exitButton then
				window:setDefaultEscapeButton(label)
			end
		end
	end
	for index, options in pairs(modalConfig.choices) do
		if not options.checkVisibility or options.checkVisibility(self) then
			window:addChoice(options.label, index)
		end
	end
	window:sendToPlayer(self)
	return true
end