-- Copyright (c) 2016 Gabriel Pérez-Cerezo, licensed under WTFPL.
atm = {}
atm.balance = {}
atm.pth = minetest.get_worldpath().."/atm_accounts"
local modpath = minetest.get_modpath("atm")


function atm.showform (player)
	atm.readaccounts()
	if not atm.balance[player:get_player_name()] then
		atm.balance[player:get_player_name()] = 30
	end 
	local formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1.25,0.5;Money input]" ..
	"label[5.25,0.5;Money output]" ..
	"label[2.5,0.15;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"button_exit[2.5,1.5;1,2;Quit;Quit]" ..
	"item_image_button[0.5,1;1,1;".. "currency:minegeld" ..";i1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[1.5,1;1,1;".. "currency:minegeld_5" ..";i5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[2.5,1;1,1;".. "currency:minegeld_10" ..";i10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[4.5,1;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[5.5,1;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[6.5,1;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[]"..
      default.get_hotbar_bg(0, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form", gui)
		end, formspec)
end


function atm.showform2 (player)
	atm.readaccounts()
	if not atm.balance[player:get_player_name()] then
		atm.balance[player:get_player_name()] = 30
	end 
	local formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1.25,0.5;Money input]" ..
	"label[5.25,0.5;Money output]" ..
	"label[2.5,0.15;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"button_exit[2.5,2.5;1,2;Quit;Quit]" ..
	"item_image_button[0.5,1;1,1;".. "currency:minegeld" ..";i1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[1.5,1;1,1;".. "currency:minegeld_5" ..";i5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[2.5,1;1,1;".. "currency:minegeld_10" ..";i10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[4.5,1;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[5.5,1;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[6.5,1;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[0.5,2;1,1;".. "currency:minegeld" ..";t10;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[1.5,2;1,1;".. "currency:minegeld_5" ..";t50;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[2.5,2;1,1;".. "currency:minegeld_10" ..";t100;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[4.5,2;1,1;".. "currency:minegeld" ..";t-10;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[5.5,2;1,1;".. "currency:minegeld_5" ..";t-50;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[6.5,2;1,1;".. "currency:minegeld_10" ..";t-100;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[]"..
	default.get_hotbar_bg(0, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form2", gui)
		end, formspec)
end


function atm.showform3 (player)
	atm.readaccounts()
	if not atm.balance[player:get_player_name()] then
		atm.balance[player:get_player_name()] = 30
	end 
	local formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1.25,0.5;Money input]" ..
	"label[5.25,0.5;Money output]" ..
	"label[2.5,0.15;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"button_exit[3.5,2.75;1,2;Quit;Quit]" ..
	"item_image_button[0.5,1;1,1;".. "currency:minegeld" ..";i1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[1.5,1;1,1;".. "currency:minegeld_5" ..";i5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[2.5,1;1,1;".. "currency:minegeld_10" ..";i10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[4.5,1;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[5.5,1;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[6.5,1;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[0.5,2;1,1;".. "currency:minegeld" ..";t10;\n\n\b\b\b\b\b" .. "1" .."]" ..
	"item_image_button[1.5,2;1,1;".. "currency:minegeld_5" ..";t50;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[2.5,2;1,1;".. "currency:minegeld_10" ..";t100;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[4.5,2;1,1;".. "currency:minegeld" ..";t-10;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[5.5,2;1,1;".. "currency:minegeld_5" ..";t-50;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[6.5,2;1,1;".. "currency:minegeld_10" ..";t-100;\n\n\b\b\b\b\b" .. "10" .."]" ..
	"item_image_button[0.5,3;1,1;".. "currency:minegeld" ..";c100;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"item_image_button[1.5,3;1,1;".. "currency:minegeld_5" ..";c500;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"item_image_button[2.5,3;1,1;".. "currency:minegeld_10" ..";c1000;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"item_image_button[4.5,3;1,1;".. "currency:minegeld" ..";c-100;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"item_image_button[5.5,3;1,1;".. "currency:minegeld_5" ..";c-500;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"item_image_button[6.5,3;1,1;".. "currency:minegeld_10" ..";c-1000;\n\n\b\b\b\b\b" .. "100" .."]" ..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[]"..
	default.get_hotbar_bg(0, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form3", gui)
		end, formspec)
end



function atm.readaccounts ()
	local b = atm.balance
	local file = io.open(atm.pth, "r")
	if file then
		repeat
			local balance = file:read("*n")
			if balance == nil then
				break
			end
			local name = file:read("*l")
			b[name:sub(2)] = balance
		until file:read(0) == nil
		io.close(file)
	else
		b = {}
	end
end

function atm.saveaccounts()
	if not atm.balance then
		return
	end
	local data = {}
	for k, v in pairs(atm.balance) do
		table.insert(data, string.format("%d %s\n", v, k))
	end

	local output = io.open(atm.pth, "w")
	output:write(table.concat(data))
	io.close(output)
end

minetest.register_on_joinplayer(function(player)
	atm.readaccounts()
end)

minetest.register_node("atm:atm", {
	description = "ATM",
	tiles = {
		"atm_top.png", "atm_top.png",
		"atm_side.png", "atm_side.png",
		"atm_side.png", "atm_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		atm.showform(player)
	end,
})

minetest.register_node("atm:atm2", {
	description = "ATM model 2",
	tiles = {
		"atm2_top.png", "atm2_top.png",
		"atm2_side.png", "atm2_side.png",
		"atm2_side.png", "atm2_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		atm.showform2(player)
	end,
})

minetest.register_node("atm:atm3", {
	description = "ATM model 3",
	tiles = {
		"atm3_top.png", "atm3_top.png",
		"atm3_side.png", "atm3_side.png",
		"atm3_side.png", "atm3_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 3},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		atm.showform3(player)
	end,
})

-- Check the form

minetest.register_on_player_receive_fields(function(player, form, pressed)

	if form == "atm.form" or form == "atm.form2" or form == "atm.form3" then
		local n = player:get_player_name()
		local transaction = { amount = 0, denomination = 0, count = 0 }
		local pinv=player:get_inventory()
                                          
		-- single note transactions
		for _,i in pairs({1, 5, 10, -1, -5, -10}) do
			if pressed["i"..i] then
				transaction.amount = i
				transaction.denomination = '_' .. math.abs(i)
				if transaction.denomination == '_1' then
					transaction.denomination = ''
				end
				transaction.count = ' ' .. 1
				break
			end
		end

		-- 10x banknote transactions
		for _,t in pairs({10, 50, 100, -10, -50, -100}) do
			if pressed["t"..t] then
				transaction.amount = t
				transaction.denomination = '_' .. math.abs(t/10)
				if transaction.denomination == '_1' then
					transaction.denomination = ''
				end
				transaction.count = ' ' .. 10
				break
			end
		end

		-- 100x banknote transactions
		for _,c in pairs({100, 500, 1000, -100, -500, -1000}) do
			if pressed["c"..c] then
				transaction.amount = c
				transaction.denomination = '_' .. math.abs(c/100)
				if transaction.denomination == '_1' then
					transaction.denomination = ''
				end
				transaction.count = ' ' .. 100
				break
			end
		end
                                          
		if (atm.balance[n] + transaction.amount) < 0 then
			minetest.chat_send_player(n, "Not enough money in your account")
			transaction.amount = 0
		end

		local item = "currency:minegeld" .. transaction.denomination .. transaction.count

		if transaction.amount < 0 then
			if pinv:room_for_item("main", item) then
				pinv:add_item("main", item)
				atm.balance[n] = atm.balance[n] + transaction.amount
			else
				minetest.chat_send_player(n, "Not enough room in your inventory")
			end

		elseif transaction.amount > 0 then
			if pinv:contains_item("main", item) then
				pinv:remove_item("main", item)
				atm.balance[n] = atm.balance[n] + transaction.amount
			else
				minetest.chat_send_player(n, "Not enough money in your inventory")
			end
		end

		atm.saveaccounts()

		if not pressed.Quit and not pressed.quit then
			if form == "atm.form" then
				atm.showform(player)
			elseif form == "atm.form2" then
				atm.showform2(player)
			elseif form == "atm.form3" then
				atm.showform3(player)
			end
		end
	end

end)

local cheaper_part = "default:copper_ingot"

if minetest.get_modpath("mesecons") then
	cheaper_part = "mesecons:wire_00000000_off"
end

minetest.register_craft({
	output = "atm:atm",
	recipe = {
		{"default:steel_ingot", cheaper_part, "default:steel_ingot"},
		{"default:glass", "currency:minegeld", "default:steel_ingot"},
		{"default:steel_ingot", cheaper_part, "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "atm:atm2",
	recipe = {
		{"default:steel_ingot", cheaper_part, "default:steel_ingot"},
		{"default:glass", "currency:minegeld_5", "default:steel_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "atm:atm3",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"default:glass", "currency:minegeld_10", "default:steel_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"}
	}
})


dofile(modpath .. "/interest.lua")
