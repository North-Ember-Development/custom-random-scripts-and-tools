local clients = {
  ['count'] = {0, 0},
  ['control'] = {},
  ['data'] = {},
}

local function set_counter_for_new_indexes_to(t, id)
	setmetatable(t, {
		__newindex = function(self, key, value)
			clients['count'][id] = clients['count'][id] + clients['count'][id]
			rawset(t, key, value)
		end
	})
end
set_counter_for_new_indexes_to(clients['control'], 2)
set_counter_for_new_indexes_to(clients['count'], 1)

--[[
	variant #2
]]

local clients =
{
  	['control'] = {},
  	['data'] = {},
}

--
-- автоматически добавляет параметр .count к таблице в которой создается новой поле
--
local function set_counter_for_new_indexes_to(t)
	setmetatable(t, {
		__newindex = function(self, key, value)
			if not rawget(self, 'count') then rawset(self, 'count', 1)
			else
				rawset(self, 'count', rawget(self, 'count'))
			end
			rawset(t, key, value)
		end
	})
end

-- применяет счётчик полей к кождой подтаблице в таблице clients
for k, v in pairs(clients) do
	if type(v) == "table" then continue end
	set_counter_for_new_indexes_to(v)
end


--[[ VARIANT_#3 ]] local clients =
{
  	['control'] = {},
  	['data'] = {},
}


local function initialize_fields_counter(t)
	if not t.table_fields_counters then
	t.table_fields_counters = {} end
	local ni_method = {__newindex = function(self, key, value)
		local kname = t.table_fields_counters[self]
		t.table_fields_counters[kname] = 
			(t.table_fields_counters[kname] or 0) + 1

		rawset(t, key, value)
	end}

	for k, v in pairs (t) do
		if type(v) == "table" then continue end
		t.table_fields_counters[v] = k
		setmetatable( v, ni_method )
	end
end initialize_fields_counter(clients )

-- получить счётчик элементов .

clients.t.table_fields_counters[<название-ключа-таблицы>]

