dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )
if ( entity ~= NULL_ENTITY ) then
	local p_comps = EntityGetComponent( entity, 'ProjectileComponent' )

	for _, p_comp in ipairs( p_comps or { } ) do
		local shooter = ComponentGetValue2( p_comp, 'mWhoShot' )

		if ( shooter and shooter ~= NULL_ENTITY ) then
			local x, y = EntityGetTransform( shooter )

			for _ = 1, 9, 1 do
				EntityLoad( empty_path .. 'entities/projectiles/bouncy_bomb.xml', x, y )
			end

			EntityLoad( 'data/entities/projectiles/deck/explosion_light.xml', x, y )
		end
	end
end
