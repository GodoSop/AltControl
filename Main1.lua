local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local owner = "sxjihbm"
local followToggle = false
local autochatToggle = false
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

-- Follow person
function follow(message)
	if message.Text == "!followt" and message.TextSource.UserId == Players[owner].UserId then
		followToggle = false
	elseif message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 7) == "!walkto" and searchName(removeCommand(message.Text, "!walkto")) then
		followToggle = true
		if followToggle then
			LocalPlayer.Character:MoveTo(searchName(removeCommand(message.Text, "!walkto")).Character.HumanoidRootPart.Position)
		end
		while followToggle and wait() do
			LocalPlayer.Character.Humanoid:MoveTo(searchName(removeCommand(message.Text, "!walkto")).Character.HumanoidRootPart.Position)
		end
	end
end

--Speak
function Chat(msg)
	if game.ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents') then
		game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
	else
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
	end
end

function speak(message)
	if message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 6) == "!speak" then
		Chat(removeCommand(message.Text, "!speak"))
	end
end

--Teleport
function teleport(message)
	if message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 3) == "!tp" and searchName(removeCommand(message.Text, "!tp")) then
		LocalPlayer.Character:MoveTo(searchName(removeCommand(message.Text, "!tp")).Character.HumanoidRootPart.Position)
	end
end

-- Respawn
function respawn(message)
	if message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 8) == "!respawn" then
		LocalPlayer.Character.Humanoid.Health = 0
	end
end

--Autochat
local letters = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z"
}

function randText()
	local Text = ""
	for i = 1, 6 do
		Text = Text .. letters[math.random(1, #letters)]
	end
	return Text
end

function autochat(message)
	if message.Text == "!autot" and message.TextSource.UserId == Players[owner].UserId then
		autochatToggle = false
	elseif message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 9) == "!autochat" then
		autochatToggle = true
		if autochatToggle then
			Chat(randText() .. " " .. removeCommand(message.Text, "!autochat"))
		end
		while autochatToggle and wait(math.random(6, 9)) do
			Chat(randText() .. " " .. removeCommand(message.Text, "!autochat"))
		end
	end
end

--Trasnfer ownership
function ownership(message)
	if message.TextSource.UserId == Players[owner].UserId and string.sub(message.Text, 1, 6) == "!owner" and searchName(removeCommand(message.Text, "!owner")) then
		owner = searchName(removeCommand(message.Text, "!owner")).Name
	end
end

TextChatService.OnIncomingMessage = function(message)
	follow(message)
	speak(message)
	respawn(message)
	teleport(message)
	autochat(message)
	ownership(message)
end
