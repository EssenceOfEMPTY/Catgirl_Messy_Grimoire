dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = EntityGetParent( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local comp = EntityGetFirstComponent( entity, 'DamageModelComponent' )

	local resists = { 'drill', 'electricity', 'explosion', 'fire', 'ice', 'melee', 'projectile', 'radioactive', 'slice' }

	if ( comp ) then
		for a, b in ipairs( resists ) do
			local multipliers = tonumber( ComponentObjectGetValue2( comp, 'damage_multipliers', b ) ) or 2

			if ( multipliers < 0 ) then
				multipliers = 2
			end

			ComponentObjectSetValue2( comp, 'damage_multipliers', b, tostring( multipliers - 1 ) )
		end
	end

	local c = EntityGetAllChildren( entity )

	for _, v in ipairs( c or { } ) do
		if EntityHasTag( v, 'effect_resistance' ) then
			EntitySetComponentsWithTagEnabled( v, 'effect_resistance', true )
		end
	end
end
