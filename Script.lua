-- NOTE: PLEASE INVITE THE DISCORD BOT FIRST: https://discord.com/oauth2/authorize?client_id=874295389711396954&permissions=128&scope=bot

-- Place this inside of ServerScriptService.

-----------------------------------------------------------------------------

-- Configuration --

local guildid = "12345" -- Insert your Discord guild ID here. To find this, watch this Gyazo: https://gyazo.com/bbe2678eea5283c6fcbddef2bd9f7319 // If you need help, visit https://docs.heyimpatrick.com/v/v2/basic-help/setting-up-the-nitro-tags#obtaining-a-guild-id

local backendType = "Defualt" -- Please enter what backend you are using. Possible choices are: "Defualt", or "Other"
-- If you are using a self hosted backend or any other service, change the backendType to "Other", and supply the URL below. Further code alterations will be needed on lines 10 thru 100.

local URL = "N/A" -- I am not responsible for any negative actions used with your own custom backend. If you are using the defualt backend, leave this. If you are using a custom backend, also make sure you include a "/" on the end. Ex: "https://google.com/"

function isbooster(plr)
	-- Here's where you should insert your code after the player is a booster. In this case, we're having our Nitro Booster tag clone to our character. This function passes thru a player's instance.
	script.BillboardGui:Clone().Parent = plr.Character.Head
end

-----------------------------------------------------------------------------

-- Most likely no further alterations are needed below unless you are using a custom backend or another service (not including Polaris aka "Defualt").

local limit = 30
local reset = 60
local rates = 0

game.Players.PlayerAdded:Connect(function(plr)
	local http = game:GetService("HttpService") -- gets the service
	local discordid -- variable for users discordid
	local response -- variable for url response
	local data -- variable for url data
	local c = false -- makes sure that if a user boosted with more then one linked account, the same perks don't happen twice such as cloning the nametag twice.

	-- Now it's time to call for their DiscordID from their RobloxID. For this, I'm using Neztore's API, but you can use your own or even if you have a RoVer API key, RoVer's. (altho i couldn't find any proper documentation for the reverse api)
	-- You are expected to alter the code to fit your API of choice. However if you plan to leave it as defualt, no alterations are necessary for this to work.

	function limit()
		rates = rates + 1
		delay(reset, function()
			rates = rates - 1
		end)
	end

	if rates == limit then wait(60) end
	limit()
	if backendType == "Defualt" then
		pcall(function ()
			response = http:GetAsync("https://verify.nezto.re/api/reverse/"..plr.UserId)
			discordid = http:JSONDecode(response)
			if discordid ~= nil then
				for _,v in pairs(discordid) do
					pcall(function ()
						response = http:GetAsync("https://v2.heyimpatrick.com/v2/?guild="..guildid.."&id="..v.discordId)
						data = http:JSONDecode(response)
						if data.isBooster == true and c == false then
							c = true
							isbooster(plr)
						end
					end)
				end
			end
		end)
	end
	if backendType == "Other" then
		-- Supply your own code here! If you are using a custom backend (and using the backend code), no changes are needed.
		
		-- Uses plr variable as player instance.
		
		pcall(function ()
			response = http:GetAsync("https://verify.nezto.re/api/reverse/"..plr.UserId)
			discordid = http:JSONDecode(response)
			if discordid ~= nil then
				for _,v in pairs(discordid) do
					pcall(function ()
						response = http:GetAsync(URL.."?guild="..guildid.."&id="..v.discordId)
						data = http:JSONDecode(response)
						if data.isBooster == true and c == false then
							c = true
							isbooster(plr)
						end
					end)
				end
			end
		end)
	end
end)

-- if you need help, add me: "not patriсk#0001" or use a contact method on the devforums post
