local function isempty(s)
  return s == nil or s == ''
end

local handle_after_place = function(pos, placer, itemstack, pointed_thing)
  -- Store node owner
  local meta = minetest.get_meta(pos)
  local owner = placer:get_player_name()
  meta:set_string("owner", owner)
  -- Ensure owner's account exists
  atm.ensure_init(owner)
end

local tube_config = {
  can_insert = function(pos, node, stack, direction)
    local accept = false
    -- Check ATM has owner
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    if not isempty(owner) then
      local input = ItemStack(stack)
      local input_name = input:get_name()
      accept = input_name:match('^currency:minegeld_%d+$') or
        input_name:match('^currency:minegeld$')
    end
    return accept
  end,
  insert_object = function(pos, node, stack, direction)
    local input = ItemStack(stack)
    local input_name = input:get_name()
    local return_stack = nil
    local minegeld_type = nil
    local mg_count = 0
    -- Get ATM owner
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    -- Determine minegeld type
    if input_name:match('^currency:minegeld_%d+$') then
      minegeld_type = string.gsub(input_name, "currency:minegeld_", "")
      minegeld_type = tonumber(minegeld_type)
    elseif input_name:match('^currency:minegeld$') then
      minegeld_type = 1
    end
    -- Count minegeld
    if not isempty(minegeld_type) then
      mg_count = minegeld_type * input:get_count()
    end
    -- Update player balance if possible,
    -- return input stack otherwise
    if not isempty(mg_count) then
      atm.balance[owner] = math.floor(atm.balance[owner] + mg_count)
      atm.saveaccounts()
      minetest.chat_send_player(
        owner,
        "Received " .. mg_count .. " minegeld by tube; balance: " .. atm.balance[owner]
      )
    else
      return_stack = stack
    end
    -- Return unrelated items
    return ItemStack(return_stack)
  end,
  connect_sides = {
    left = 1, right = 1,
    front = 1, back = 1,
    top = 1, bottom = 1
  }
}

-- ATM node definitions
minetest.register_node("atm:atm", {
  description = "ATM",
  tiles = {
    "atm_top.png", "atm_top.png",
    "atm_side.png", "atm_side.png",
    "atm_side.png", "atm_front.png"
  },
  paramtype2 = "facedir",
  groups = {cracky = 2, bank_equipment = 1},
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),

  on_rightclick = function(_, _, player)
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
  groups = {cracky = 2, bank_equipment = 2},
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),

  on_rightclick = function(_, _, player)
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
  groups = {
    cracky = 2, bank_equipment = 1,
    tubedevice = 1, tubedevice_receiver = 1
  },
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
  on_rightclick = function(_, _, player)
    atm.showform3(player)
  end,
  after_place_node = handle_after_place,
  tube = tube_config,
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
  groups = {
    cracky = 2, bank_equipment = 1,
    tubedevice = 1, tubedevice_receiver = 1
  },
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
  on_rightclick = function(_, _, player)
    atm.showform_wt(player)
  end,
  after_place_node = handle_after_place,
  tube = tube_config,
})
