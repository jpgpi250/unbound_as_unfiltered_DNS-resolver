-- file copied from https://gist.github.com/TonyStarkBy/28a781eb3c9f0c2a7e1f
-- how to use: 
-- redis-cli EVAL "$(cat redis-idle-clean.lua)" 2 key_name 86400

local keyTemplate = KEYS[1]
local keyMinIdleTime = tonumber(KEYS[2])


local function getUsedMemory()
	local info = redis.call('info')

	for i in string.gmatch(info, "%S+") do
		local key,val =  string.match(i, '(%S+):(%d+)')
		if (key == 'used_memory') then
			return tonumber(val)
		end
	end

	return -1
end


local matches = redis.call('KEYS', keyTemplate .. '*')
local deleted = 0
local usedMemoryBefore = getUsedMemory()

for _,key in ipairs(matches) do
	local idle = redis.call('OBJECT', 'IDLETIME', key)
	if (idle > keyMinIdleTime) then
		redis.call('DEL', key)
		deleted = deleted + 1
	end
end

local memoryFreed = usedMemoryBefore - getUsedMemory()

local result = {
"Total keys: " .. table.getn(matches),
"Deleted keys: " .. deleted,
"Memory freed: " .. memoryFreed
}

return result
