dofile_once('data/scripts/lib/utilities.lua')

local entity_id = GetUpdatedEntityID( )
local player_id = EntityGetParent( entity_id )

if ( player_id ~= NULL_ENTITY ) and ( entity_id ~= player_id ) then
	local comp = EntityGetFirstComponent( player_id, 'DamageModelComponent' )
	local comps = EntityGetComponent( entity_id, 'VariableStorageComponent' )

	local resists = { 'drill', 'electricity', 'explosion', 'fire', 'ice', 'melee', 'projectile', 'radioactive', 'slice' }
	-- local result = ''

	if ( comp ) and ( comps ) then
		--[[ for _, v in ipairs( comps ) do
			local n = ComponentGetValue2( v, 'name' )

			if ( n == 'wither_data' ) then
				result = ComponentGetValue2( v, 'value_string' )
				break
			end
		end

		if ( #result > 0 ) then
			local data = {}

			for r in string.gmatch( result, '%S+' ) do
				table.insert( data, r )
			end

			for a,b in ipairs( resists ) do
				local r = tostring( data[a] ) or '1.0'

				ComponentObjectSetValue2( comp, 'damage_multipliers', b, r )
			end
		end]]--
		for a, b in ipairs( resists ) do
			local multipliers = tonumber( ComponentObjectGetValue2( comp, 'damage_multipliers', b ) ) or 2

			if multipliers < 0 then
				multipliers = 2
			end

			ComponentObjectSetValue2( comp, 'damage_multipliers', b, tostring( multipliers - 1 ) )
		end
	end

	local c = EntityGetAllChildren( player_id )

	if ( c ) then
		for _, v in ipairs( c ) do
			if EntityHasTag( v, 'effect_resistance' ) then
				EntitySetComponentsWithTagEnabled( v, 'effect_resistance', true )
			end
		end
	end
end
