atm = {}
atm.balance = {}
atm.pth = minetest.get_worldpath().."/atm_accounts"
atm.linecount = 0

function atm.showform (player)
   atm.readaccounts()
   if not atm.balance[player:get_player_name()] then
      atm.balance[player:get_player_name()] = 0
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
      "item_image_button[5,1;1,1;".. "currency:minegeld" ..";m1;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[6,1;1,1;".. "currency:minegeld_5" ..";m5;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "item_image_button[7,1;1,1;".. "currency:minegeld_10" ..";m10;\n\n\b\b\b\b\b" .. "1" .."]" ..
      "list[current_player;main;0,4.25;8,1;]"..
      "list[current_player;main;0,5.5;8,3;8]"..
      "listring[]"..
      default.get_hotbar_bg(0, 4.25)
   minetest.after((0.1), function(gui)
	 return minetest.show_formspec(player:get_player_name(), "atm.form",gui)
			 end, formspec)
end


function atm.readaccounts () 
   local file = io.open(atm.pth, "r")
   local l = 0
   if file then
      repeat
	 l = l + 1
	 local balance = file:read("*n")
	 if x == nil then
	    break
	 end
	 local name = file:read("*l")
	 atm.balance[name:sub(2)] = balance
      until file:read(0) == nil
      io.close(file)
      atm.linecount = l
   else
      atm.balance = {}
   end
end

function atm.saveaccounts()
   if not atm.balance then
      return
   end
   local data = {}

   local l = 0
   for k, v in pairs(atm.balance) do
      table.insert(data, string.format("%d %s\n", v, k))
      l = l+1
   end
   if not (l < atm.linecount) then
      local output = io.open(atm.pth, "w")
      output:write(table.concat(data))
      io.close(output)
   end

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

			  on_construct = function(pos)
			     local meta = minetest.get_meta(pos)
--			     meta:set_string("formspec", formspec)
			     local inv = meta:get_inventory()
			     inv:set_size('in', 3)
			  end,
			  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			     atm.showform(player)
			  end,

			  on_blast = function(pos)
			     local drops = {}
			     default.get_inventory_drops(pos, "src", drops)
			     drops[#drops+1] = "atm:atm"
			     minetest.remove_node(pos)
			     return drops
			  end,

			  allow_metadata_inventory_put = allow_metadata_inventory_put,
			  allow_metadata_inventory_move = allow_metadata_inventory_move,
			  allow_metadata_inventory_take = allow_metadata_inventory_take,
})
-- Check the form

minetest.register_on_player_receive_fields(function(player, form, pressed)

      if form == "atm.form" then
	 local n = player:get_player_name()
	 local amount = 0
	 local fail = 0
	 local pinv=player:get_inventory()
	 local m1 = "currency:minegeld"
	 if pressed.i1 then
	    amount = 1
	 end
	 if pressed.i5 then
	    amount = 5
	 end
	 if pressed.i10 then
	    amount = 10
	 end
	 if pressed.m1 then
	    amount = -1
	 end
	 if pressed.m5 then
	    amount = -5
	 end
	 if pressed.m10 then
	    amount = -10
	 end
	 if (atm.balance[n] + amount) < 0 then
	    minetest.chat_send_player(n, "Not enough money in your account")
	    amount = 0
	 end

	 if amount == 1 then
	    if pinv:contains_item("main", m1 ) then
	       pinv:remove_item("main", m1)
	    else
	       fail = 1
	    end
	 elseif amount == -1 then
	    if pinv:room_for_item("main", m1) then
	       pinv:add_item("main", m1)
	    else
	       fail=-1
	    end
	 elseif amount < 0 then
	    if pinv:room_for_item("main", "currency:minegeld_"..-amount) then
	       pinv:add_item("main", "currency:minegeld_"..-amount)
	    else
	       fail=-1
	    end
	 elseif amount > 0 then
	    if pinv:contains_item("main", "currency:minegeld_"..amount ) then
	       pinv:remove_item("main", "currency:minegeld_"..amount)
	    else
	       fail = 1
	    end
	 end
	 if fail == 1 then
	    minetest.chat_send_player(n, "Not enough money in your inventory")
	 elseif fail == -1 then
	    minetest.chat_send_player(n, "Not enough room in your inventory")
	 else
	    atm.balance[n] = atm.balance[n] + amount
	 end
	 atm.saveaccounts()
	 if not pressed.Quit then
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
