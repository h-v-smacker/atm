local storage = minetest.get_mod_storage()

function atm.create_account(name)
	if not storage:contains("balance_" .. name) and minetest.player_exists(name) then
		storage:set_int("balance_" .. name, atm.startbalance)
		atm.balance[name] = atm.startbalance
	end
end

-- banking accounts storage
function atm.read_account(name)
	if atm.balance[name] ~= nil then return end
	if storage:contains("balance_" .. name) then
		atm.balance[name] = storage:get_int("balance_" .. name)
	else
		atm.create_account(name)
	end
end

function atm.save_account(name)
	if atm.balance[name] then
		storage:set_int("balance_" .. name, atm.balance[name])
		return true
	end
	return false
end

function atm.migrate_accounts()
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
			if b[name:sub(2)] ~= atm.startbalance then
				atm.save_account(name:sub(2))
			end
		until file:read(0) == nil
		io.close(file)
	end
	os.remove(atm.pth)
	minetest.log("action", "[atm] Migrated all accounts")
end

-- wire transfer data storage
function atm.read_transaction(name)
	if atm.completed_transactions[name] ~= nil then return end
	local s = storage:get_string("transaction_" .. name)
	if s == nil then return end
	local t = minetest.deserialize(s)
	if t == nil then return end
	atm.completed_transactions[name] = t
end

function atm.write_transaction(name)
	if atm.completed_transactions[name] == nil then
		storage:set_string("transaction_" .. name, "")
	else
		local s = minetest.serialize(atm.completed_transactions[name])
		if s == nil then return end
		storage:set_string("transaction_" .. name, s)
	end
end

function atm.migrate_transactions()
	local file = io.open(atm.pth_wt, "r")
	if file then
		local data = file:read("*all")
		atm.completed_transactions = minetest.deserialize(data)
		io.close(file)
	end
	for name, table in pairs(atm.completed_transactions) do
		atm.write_transaction(name)
	end
	os.remove(atm.pth_wt)
	minetest.log("action", "[atm] Migrated all transactions")
end

minetest.register_on_leaveplayer(function(player)
	if player then
		local name = player:get_player_name()
		atm.balance[name] = nil
		atm.completed_transactions[name] = nil
		atm.pending_transfers[name] = nil
	end
end)

minetest.register_on_mods_loaded(function()
	local file = io.open(atm.pth, "r")
	if file then
		io.close(file)
		atm.migrate_accounts()
	end
	file = io.open(atm.pth_wt, "r")
	if file then
		io.close(file)
		atm.migrate_transactions()
	end
end)