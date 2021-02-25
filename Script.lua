-- NOTE: PLEASE INVITE THE DISCORD BOT FIRST: https://discord.com/api/oauth2/authorize?client_id=813755657172942918&permissions=128&scope=bot

-----------------------------------------------------------------------------

-- Configuration --

local guildid = "735748614428557432" -- Insert your Discord guild ID here. To find this, watch this Gyazo: https://gyazo.com/bbe2678eea5283c6fcbddef2bd9f7319

local URL = "https://nitro.heyimpatrick.com" -- Leave this defualt on the heyimpatrick domain, or hook it up with your own backend. I'm now no longer responsible for any negative actions used with your own custom backend.


function isbooster(plr)
	-- Here's where you should insert your code after the player is a booster. In this case, we're having our Nitro Booster tag clone to our character. This function passes thru a player's instance.

	script.BillboardGui:Clone().Parent = plr.Character.Head
end

-----------------------------------------------------------------------------

local limit = 30
local reset = 60
local rates = 0


game.Players.PlayerAdded:Connect(function(plr)
	local http = game:GetService("HttpService") -- gets the service
	local discordid -- variable for users discordid
	local response -- variable for url response
	local data -- variable for url data
	local c = false -- makes sure that if a user boosted with more then one linked account, the same perks don't happen twice such as cloning the nametag twice.

	-- Now it's time to call for their DiscordID from their RobloxID. For this, I'm using Neztore's API, but you can use your own or even if you have a RoVer API key, RoVer's. 
	-- You are expected to alter the code to fit your API of choice. However if you plan to leave it as defualt, no alterations are necessary for this to work.

	function limit()
		rates = rates + 1
		delay(reset, function()
			rates = rates - 1
		end)
	end

	if rates == limit then wait(60) end
	limit()
	pcall(function ()
		response = http:GetAsync("https://verify.nezto.re/api/reverse/"..plr.UserId)
		discordid = http:JSONDecode(response)
		if discordid ~= nil then
			for _,v in pairs(discordid) do
				pcall(function ()
					response = http:GetAsync(URL.."/v1/?guild="..guildid.."&id="..v.discordId)
					data = http:JSONDecode(response)
					if data.isBooster == true and c == false then
						c = true
						isbooster(plr)
					end
				end)
			end
		end
	end)
end)

-- if you need help, add me: patrick.#0723 or use a contact method on the devforums post
