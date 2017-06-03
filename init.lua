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
      "label[1,0.5;Money input]" ..
      "label[6,0.5;Money output]" ..
      "label[3,0.25;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
      "button_exit[3,2;1,2;Quit;Quit]" ..
      "item_image_button[1,1;1,1;".. "currency:minegeld" ..";i1;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[2,1;1,1;".. "currency:minegeld_5" ..";i5;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[3,1;1,1;".. "currency:minegeld_10" ..";i10;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[5,1;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[6,1;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[7,1;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "list[current_player;main;0,4.25;8,1;]"..
      "list[current_player;main;0,5.5;8,3;8]"..
      "listring[]"..
      default.get_hotbar_bg(0, 4.25)
   minetest.after((0.1), function(gui)
	 return minetest.show_formspec(player:get_player_name(), "atm.form",gui)
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
			  groups = {cracky=2},
			  legacy_facedir_simple = true,
			  is_ground_content = false,
			  sounds = default.node_sound_stone_defaults(),

			  can_dig = can_dig,

			  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			     atm.showform(player)
			  end,
})
-- Check the form

minetest.register_on_player_receive_fields(function(player, form, pressed)

      if form == "atm.form" then
	 local n = player:get_player_name()
	 local amount = 0
	 local pinv=player:get_inventory()
	 for _,i in pairs({1,5,10, -1, -5, -10}) do
	    if pressed["i"..i] then
	       amount = i
	       break
	    end
	 end
	 if (atm.balance[n] + amount) < 0 then
	    minetest.chat_send_player(n, "Not enough money in your account")
	    amount = 0
	 end
	 local item = "currency:minegeld"
	 if amount < 0 then
	    if amount < -1 then
	       item = item .. "_" .. -amount
	    end
	    if pinv:room_for_item("main", item) then
	       pinv:add_item("main", item)
	       atm.balance[n] = atm.balance[n] + amount
	    else
	       minetest.chat_send_player(n, "Not enough room in your inventory")
	    end
	 elseif amount > 0 then
	    if amount > 1 then
	       item = item .. "_" .. amount
	    end
	    if pinv:contains_item("main", item) then
	       pinv:remove_item("main", item)
	       atm.balance[n] = atm.balance[n] + amount
	    else
	       minetest.chat_send_player(n, "Not enough money in your inventory")
	    end
	 end
	 atm.saveaccounts()
	 if not pressed.Quit and not pressed.quit then
	    atm.showform(player)
	 end
      end

end)
minetest.register_craft({
	output = "atm:atm",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"default:glass", "currency:minegeld_5", "default:steel_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"}
	}
})
dofile(modpath .. "/interest.lua")
