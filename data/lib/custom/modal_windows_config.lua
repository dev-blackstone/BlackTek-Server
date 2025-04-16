MODAL_WINDOW_CONFIG = {
	["Difficulty"] = {
		message = "Please select one of the following difficulties:",
		choices = {
			[1] = {
				label = "Easy"
			},
			[2] = {
				label = "Hard",
				checkVisibility = function(player)
					return player:getLevel() > 400
				end
			}
		},
		buttons = {
			[1] = {
				label = "Select",
				confirmCheck = function(player, choice)
					local success, errorMessage = false, nil
					if choice.text == "Easy" then
						success = player:getLevel() > 35
						errorMessage = "Player must be level 35 or greater."
					elseif choice.text == "Hard" then
						success = player:getLevel() > 400
						errorMessage = "Player must be level 400 or greater."
					end
					return success, errorMessage
				end,
				callback = function(player, button, choice)
					player:sendModalWindow("Surfer")
					return true
				end,
				enterButton = true
			},
			[2] = {
				label = "Exit",
				callback = function(player, button, choice)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, button.name)
					return true
				end,
				exitButton = true
			},
		},
	},
	["Surfer"] = {
		message = "If you ever wanted to go surfing, select 'Yes'.",
		choices = {
			[1] = {label = "Yes"},
			[2] = {label = "No"}
		},
		buttons = {
			[1] = {
				label = "Confirm",
				callback = function(player, button, choice)
					if choice.text == "Yes" then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are a 'subway surfer now'!")
					elseif choice.text == "No" then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Lame bro...")
					end
					return true, ""
				end,
				enterButton = true
			},
			[2] = {
				label = "Back",
				callback = function(player)
					player:sendModalWindow("Difficulty")
					return true
				end,
				exitButton = true
			},
		},
	}
}