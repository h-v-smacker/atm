-- For backwards compability, check if 50 and 100 Minegeld notes exist
local mg50_exists = minetest.registered_items["currency:minegeld_50"] ~= nil
local mg100_exists = minetest.registered_items["currency:minegeld_100"] ~= nil

-- abbreviation/symbol of the currency
local MONEY_SYMBOL = "Mg" -- Mg = Minegeld

local denominations = { 1, 5, 10 }
if mg50_exists then
	table.insert(denominations, 50)
end
if mg100_exists then
	table.insert(denominations, 100)
end
local rownames = { "i", "t", "c" }

local create_currency_buttons = function(cols, rows, xstart, ystart, gap)
	local formstring = ""
	for c=1, cols do
	for r=1, rows do
		local amount = 10 ^ (r-1)
		local x = xstart + (c-1)
		local xo = x + cols + gap
		local y = ystart + (r-1)
		local denom = denominations[c]
		local item = "currency:minegeld"
		if denom > 1 then
			item = item .. "_"..tostring(denom)
		end
		local multiplier = denom * (10 ^ (r-1))
		local rowname = rownames[r]
		formstring = formstring .. "item_image_button["..x..","..y..";1,1;"..item..";"..
				rowname..tostring(multiplier)..";\n\n\b\b\b\b\b"..tostring(amount).."]"
		formstring = formstring .. "item_image_button["..xo..","..y..";1,1;"..item..";"..
				rowname..tostring(-multiplier)..";\n\n\b\b\b\b\b"..tostring(amount).."]"
	end
	end
	return formstring
end

-- ATM model 1
function atm.showform (player)
	atm.read_account(player:get_player_name())
	local formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[2.5,0.15;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .."]" ..
	"button_exit[2.5,1.5;1,2;Quit;Quit]" ..
	create_currency_buttons(3, 1, 0.5, 1, 1) ..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	default.get_hotbar_bg(0, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form", gui)
		end, formspec)
end


-- ATM model 2
function atm.showform2 (player)
	atm.read_account(player:get_player_name())
	local xplus = 0
	local cols = 3
	local listx = 0
	local startx = 0.5
	if mg50_exists then
		xplus = 1
		cols = cols + 1
		listx = listx + 0.5
		startx = 0
	end
	local formspec =
	"size["..(8+xplus)..",8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1.25,0.5;Money input]" ..
	"label["..(5.25+xplus)..",0.5;Money output]" ..
	"label[2.5,0.15;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .. "]" ..
	"button_exit["..(4+xplus)..",2.5;1,2;Quit;Quit]" ..
	create_currency_buttons(cols, 2, startx, 1, 1) ..
	"list[current_player;main;"..(listx)..",4.25;8,1;]"..
	"list[current_player;main;"..(listx)..",5.5;8,3;8]"..
	default.get_hotbar_bg(listx, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form2", gui)
		end, formspec)
end


-- ATM model 3
function atm.showform3 (player)
	atm.read_account(player:get_player_name())
	local xplus = 0
	local xplus_out = 0
	local cols = 3
	local listx = 0
	local gap = 1
	local xstart = 0
	if mg50_exists then
		xplus = xplus + 1
		xplus_out = 0.5
		listx = listx + 0.5
		cols = cols + 1
		gap = 1
	end
	if mg100_exists then
		xplus = xplus + 1.5
		listx = listx + 0.75
		cols = cols + 1
		gap = 0.5
	end
	if mg50_exists and mg100_exists then
		xplus_out = 1
	end
	if not mg50_exists and not mg100_exists then
		xstart = 0.5
	end
	local formspec =
	"size["..(8+xplus)..",8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1.25,0.5;Money input]" ..
	"label["..(5.75+xplus_out)..",0.5;Money output]" ..
	"label[2.5,0.15;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .. "]" ..
	"button_exit["..(7+xplus)..",-0.5;1,2;Quit;Quit]" ..
	create_currency_buttons(cols, 3, xstart, 1, gap) ..
	"list[current_player;main;"..listx..",4.25;8,1;]"..
	"list[current_player;main;"..listx..",5.5;8,3;8]"..
	default.get_hotbar_bg(listx, 4.25)
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form3", gui)
		end, formspec)
end



-- wire transfer interface

function atm.showform_wt (player)
	atm.read_account(player:get_player_name())
	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"button[5.75,0;2,1;transactions;Transactions >]" ..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .. "]" ..
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
	atm.read_account(player:get_player_name())
	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .. "]" ..
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
	atm.read_account(player:get_player_name())

	local textlist = ''

	if not tlist then
		textlist = "no transactions registered\n"
	else
		for _, entry in ipairs(tlist) do
			textlist = textlist .. entry.date .. " " .. entry.sum .. " " .. MONEY_SYMBOL ..
					" from " .. entry.from .. ": " .. entry.desc .. "\n"
		end
	end

	local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"button[5.75,0;2,1;transfer;< Transfer money]" ..
	"label[2.5,0;Wire Transfer Terminal]" ..
	"label[2,0.5;Your account balance: ".. atm.balance[player:get_player_name()].. " " .. MONEY_SYMBOL .. "]" ..
	"textarea[0.5,1.25;7.5,4;hst;Transaction list;" .. textlist .. "]" ..
	"button_exit[0.2,5;1,1;Quit;Quit]" ..
	"button[4.7,5;3,1;clr;Clear transactions]"
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wtl", gui)
		end, formspec)
end
