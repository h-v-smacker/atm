-- adapted from the income.lua file from the currency mod.
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer >= 1000 then
		timer = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			atm.read_account(name)
			if atm.balance[name] then
				atm.balance[name] = math.floor(atm.balance[name] + 5)
				atm.save_account(name)
			end
		end
	end
end)
