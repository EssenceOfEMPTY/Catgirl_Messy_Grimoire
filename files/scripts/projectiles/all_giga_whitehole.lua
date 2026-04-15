
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local projectiles = EntityGetWithTag( 'projectile' )

if ( #projectiles > 0 ) then
	for i,projectile_id in ipairs( projectiles ) do
		local tags = EntityGetTags( projectile_id )

		if ( not tags ) or ( string.find( tags, 'black_hole' ) == nil ) then
			local px, py = EntityGetTransform( projectile_id )
			local vel_x, vel_y = nil, nil

			local projectilecomponents = EntityGetComponent( projectile_id, 'ProjectileComponent' )
			local velocitycomponents = EntityGetFirstComponent( projectile_id, 'VelocityComponent' )

			if ( projectilecomponents ) then
				for j, comp_id in ipairs( projectilecomponents ) do
					ComponentSetValue2( comp_id, 'on_death_explode', '0' )
					ComponentSetValue2( comp_id, 'on_lifetime_out_explode', '0' )
				end
			end

			if ( velocitycomponents ) then
				edit_component( projectile_id, 'VelocityComponent', function( comp, vars )
					vel_x, vel_y = ComponentGetValueVector2( comp, 'mVelocity' )
				end)

				if ( not ( vel_x and vel_y ) ) then
					vel_x, vel_y = 0, 0
				end
			end

			shoot_projectile_from_projectile( projectile_id, 'data/entities/projectiles/deck/white_hole_giga.xml', px, py, vel_x, vel_y )
			EntityKill( projectile_id )
		end
	end
end
