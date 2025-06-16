local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local owner = "sxjihbm"
local looptpToggle = false

function removeCommand(message, command)
	return message:gsub("^" .. command .. "%s*", "", 1)
end

function searchName(Name)
	local Players = game.Players:GetPlayers()
	local results = {}
	for _, player in pairs(Players) do
		if player.Name:sub(1, string.len(Name)) == Name then
			table.insert(results, player)
		end
	end 
	if #results == 1 then
		return results[1]
	else
		return false
	end
end

--Auto tp
function loopTp(message)
	if message.Text == "!looptpt" and message.TextSource.UserId == Players[owner].UserId then
		looptpToggle = false
	elseif message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 7) == "!looptp" and searchName(removeCommand(message.Text, "!looptp")) then
		looptpToggle = true
		while looptpToggle and wait() do
			LocalPlayer.Character:MoveTo(searchName(removeCommand(message.Text, "!looptp")).Character.HumanoidRootPart.Position)
		end
	end
end
print("If you see this the script works 2")
TextChatService.OnIncomingMessage = function(message)
	loopTp(message)
end
