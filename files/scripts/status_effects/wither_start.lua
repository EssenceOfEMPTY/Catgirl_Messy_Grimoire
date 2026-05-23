dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = get_root_entity( )

if ( is_alive( entity ) ) then
	local comp = EntityGetFirstComponent( entity, 'DamageModelComponent' )

	local resists = { 'drill', 'electricity', 'explosion', 'fire', 'ice', 'melee', 'projectile', 'radioactive', 'slice' }

	if ( comp ) then
		for _, key in ipairs( resists ) do
			local multipliers = ComponentObjectGetValue2( comp, 'damage_multipliers', key )

			if ( multipliers < 0 ) then
				multipliers = 1
			end

			ComponentObjectSetValue2( comp, 'damage_multipliers', key, multipliers + 1 )
		end
	end

	local childs = EntityGetAllChildren( entity )

	for _, v in ipairs( childs or { } ) do
		if EntityHasTag( v, 'effect_resistance' ) then
			EntitySetComponentsWithTagEnabled( v, 'effect_resistance', false )
		end
	end
end
