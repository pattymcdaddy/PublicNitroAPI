-- NOTE: PLEASE INVITE THE DISCORD BOT FIRST: https://discord.com/api/oauth2/authorize?client_id=813755657172942918&permissions=8&scope=bot

-----------------------------------------------------------------------------

								-- Configuration --

local guildid = "735748614428557432" -- Insert your Discord guild ID here. To find this, watch this Gyazo: https://gyazo.com/bbe2678eea5283c6fcbddef2bd9f7319


function isbooster(plr)
	-- Here's where you should insert your code after the player is a booster. In this case, we're having our Nitro Booster tag clone to our character. This function passes thru a player's instance.
	
	script.BillboardGui:Clone().Parent = plr.Character.Head
end

-----------------------------------------------------------------------------

game.Players.PlayerAdded:Connect(function(plr)
	local http = game:GetService("HttpService") -- gets the service
	
	local discordid -- variable for users discordid
	
	local response -- variable for url response
	
	local data -- variable for url data
	
	
	-- Now it's time to call for their DiscordID from their RobloxID. For this, I'm using nezto's API, but you can use your own or even if you have a RoVer API key, RoVer's.
	pcall(function ()
		response = http:GetAsync("https://verify.nezto.re/api/reverse/"..plr.UserId)
		discordid = http:JSONDecode(response)[1].discordId
	end)
	
	if discordid ~= nil then
		pcall(function ()
			response = http:GetAsync("https://nitro.heyimpatrick.com/v1/?guild="..guildid.."&id="..discordid)
			data = http:JSONDecode(response)
		end)
		if data ~= nil then
			if data.isBooster == true then
				isbooster(plr)
			end
		end
	end
end)
