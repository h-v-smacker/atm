-- Copyright (c) 2016, 2017, 2018 Gabriel Pérez-Cerezo, licensed under WTFPL.
-- Wire Transfers (c) 2018 Hans von Smacker
-- Large ATMs (C) 2017 Hans von Smacker

atm = {}
atm.balance = {}
atm.pending_transfers = {}
atm.completed_transactions = {}
atm.pth = minetest.get_worldpath().."/atm_accounts"
atm.pth_wt = minetest.get_worldpath().."/atm_wt_transactions"
local modpath = minetest.get_modpath("atm")
atm.startbalance = 30
function atm.ensure_init(name)
   -- Ensure the atm account for the placer specified by name exists
   atm.readaccounts()
   if not atm.balance[name] then
      atm.balance[name] = atm.startbalance
   end
end
   
function atm.showform (player)
	atm.ensure_init(player:get_player_name())
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
	atm.ensure_init(player:get_player_name())
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
	atm.ensure_init(player:get_player_name())
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
	"item_image_button[0.5,2;1,1;".. "currency:minegeld" ..";t10;\n\n\b\b\b\b\b" .. "10" .."]" ..
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



-- wire transfer interface

function atm.showform_wt (player)
	atm.ensure_init(player:get_player_name())
	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"button[5.75,0;2,1;transactions;Transactions >]" ..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"field[0.5,1.5;5,1;dstn;Recepient:;]"..
	"field[6,1.5;2,1;amnt;Amount:;]"..
	"field[0.5,3;7.5,1;desc;Description:;]"..
	"button_exit[0.2,5;1,1;Quit;Quit]" ..
	"button[4.7,5;3,1;pay;Complete the payment]"
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wt", gui)
		end, formspec)
end

function atm.showform_wtconf (player, dstn, amnt, desc)
	atm.ensure_init(player:get_player_name())
	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"label[2.5,1;TRANSACTION SUMMARY:]"..
	"label[0.5,1.5;Recepient: " .. dstn .. "]"..
	"label[0.5,2;Amount: " .. amnt .. "]"..
	"label[0.5,2.5;Description: " .. desc .. "]"..
	"button_exit[0.2,5;1,1;Quit;Quit]" ..
	"button[4.7,5;3,1;cnfrm;Confirm transfer]"
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wtc", gui)
		end, formspec)
end

function atm.showform_wtlist (player, tlist)
	atm.ensure_init(player:get_player_name())
	
	local textlist = ''
	
	if not tlist then
		textlist = "no transactions registered\n"
	else
		for i,entry in ipairs(tlist) do
			textlist = textlist .. entry.date .. " $" .. entry.sum .. " from " .. entry.from .. ": " .. entry.desc .. "\n"
		end
	end

	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"button[5.75,0;2,1;transfer;< Transfer money]" ..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"textarea[0.5,1.25;7.5,4;hst;Transaction list;" .. textlist .. "]" ..
	"button_exit[0.2,5;1,1;Quit;Quit]" ..
	"button[4.7,5;3,1;clr;Clear transactions]"
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wtl", gui)
		end, formspec)
end


-- banking accounts storage

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


-- wire transfer data storage

function atm.read_transactions()
	local file = io.open(atm.pth_wt, "r")
	if file then
		local data = file:read("*all")
		atm.completed_transactions = minetest.deserialize(data)
	end
end

function atm.write_transactions()
	if not atm.completed_transactions then
		return
	end
	local file = io.open(atm.pth_wt, "w")
	local data = minetest.serialize(atm.completed_transactions)
	file:write(data)
	io.close(file)
end



minetest.register_on_joinplayer(function(player)
	atm.readaccounts()
end)


-- ATM node definitions

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


-- Wire transfer terminal node

minetest.register_node("atm:wtt", {
	description = "Wire Transfer Terminal",
	tiles = {
		"atm_top.png", "atm_top.png",
		"atm_side_wt.png", "atm_side_wt.png",
		"atm_side_wt.png", "atm_front_wt.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		atm.showform_wt(player)
	end,
})


-- Check the form

minetest.register_on_player_receive_fields(function(player, form, pressed)

	-- ATMs
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
                     
	-- Wire transfer terminals
	elseif form == "atm.form.wt" or form == "atm.form.wtc" or form == "atm.form.wtl" then
		
		local n = player:get_player_name()
                                          
		if not pressed.Quit and not pressed.quit then
			if form == "atm.form.wt" and pressed.transactions then
				-- transaction list (can be edited in the form, but than means nothing)
				atm.read_transactions()
				atm.showform_wtlist(player, atm.completed_transactions[n])
			elseif form == "atm.form.wtl" and pressed.transfer then
				atm.showform_wt(player)
			elseif form == "atm.form.wtl" and pressed.clr then
				-- clear all transactions in the player's list
				atm.read_transactions()
				atm.completed_transactions[n] = nil
				atm.write_transactions() 
				minetest.chat_send_player(n, "Your transaction history has been cleared")
				atm.showform_wtlist(player, atm.completed_transactions[n])
			elseif form == "atm.form.wt" and pressed.pay then
                                          
				-- perform the checks of validity for wire transfer order
				-- if passed, store the data in a temporary table and show confirmation window
				if not atm.balance[pressed.dstn] then
					minetest.chat_send_player(n, "The recepient <" .. pressed.dstn .. "> is not registered in the banking system, aborting")
					atm.showform_wt(player)
				elseif not string.match(pressed.amnt, '^[0-9]+$') then
					minetest.chat_send_player(n, "Invalid amount <" .. pressed.amnt .. "> : must be an integer number, aborting")
					atm.showform_wt(player)
				elseif atm.balance[n] < tonumber(pressed.amnt) then
					minetest.chat_send_player(n, "Your account does not have enough funds to complete this transfer, aborting")
					atm.showform_wt(player)
				else
					atm.pending_transfers[n] = {to = pressed.dstn, sum = tonumber(pressed.amnt), desc = pressed.desc}
					atm.showform_wtconf(player, pressed.dstn, pressed.amnt, pressed.desc)
				end
                                          
			elseif form == "atm.form.wtc" then
				-- transaction processing
				atm.read_transactions()
				local t = atm.pending_transfers[n]
				if not atm.completed_transactions[t.to] then
					atm.completed_transactions[t.to] = {}
				end
                                          
				if atm.balance[n] < t.sum then
					-- you can never be too paranoid about the funds availaible
				   minetest.chat_send_player(n, "Your account does not have enough funds to complete this transfer, aborting")
				   if not t.extern then
				      atm.showform_wt(player)
				   else
				      minetest.close_formspec(n, "atm.form.wtc")
				   end
				   return
				end
                                          
				table.insert(atm.completed_transactions[t.to], {date=os.date("%Y-%m-%d"), from=n, sum=t.sum, desc=t.desc})
				atm.balance[n] = atm.balance[n] - t.sum
				atm.balance[t.to] = atm.balance[t.to] + t.sum
				atm.write_transactions() 
				atm.saveaccounts()
				minetest.chat_send_player(n, "Payment of " .. t.sum .. " to " .. t.to .. " completed")
				minetest.chat_send_player(n, n .. ", thank you for choosing the Wire Transfer system")
				if t.callback then -- run callbacks from mods
				   t.callback(t)
				end
				if t.extern == true then -- Transfer was initiated by mod
				   atm.pending_transfers[n] = nil
				   minetest.close_formspec(n, "atm.form.wtc")
				   return
				end
				atm.pending_transfers[n] = nil
				atm.showform_wt(player)
			end
		else
			-- clear the pending transaction of the player, just in case
			if atm.pending_transfers[n] then
				atm.pending_transfers[n] = nil
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

minetest.register_craft({
	output = "atm:wtt",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"default:glass", cheaper_part, "default:steel_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"}
	}
})

dofile(modpath .. "/interest.lua")
