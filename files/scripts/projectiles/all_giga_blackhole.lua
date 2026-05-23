dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local projs = EntityGetWithTag( 'projectile' )

add_table( projs, EntityGetWithTag( 'projectile_player' ) or { } )

set_comp_value( projs, 'ProjectileComponent', nil, {
	on_death_explode = false,
	on_lifetime_out_explode = false,
}, nil, nil )

for _, proj in ipairs( projs ) do
	local tags = EntityGetTags( proj )

	if ( not tags ) or ( string.find( tags, 'black_hole' ) == nil ) then
		local x, y = EntityGetTransform( proj )
		local vel_x, vel_y = nil, nil

		local v_comp = EntityGetFirstComponent( proj, 'VelocityComponent' )

		if ( v_comp ) then
			vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )
		else
			vel_x, vel_y = 0, 0
		end

		shoot_proj( proj, 'data/entities/projectiles/deck/black_hole_giga.xml', x, y, vel_x, vel_y, nil, nil, nil )

		EntityKill( proj )
	end
end
