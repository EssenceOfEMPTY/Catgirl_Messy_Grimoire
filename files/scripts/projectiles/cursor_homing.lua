dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local p_comp = EntityGetFirstComponent( entity, 'ProjectileComponent' )
local shooter

if ( p_comp ) then
	shooter = ComponentGetValue2( p_comp, 'mWhoShot' )
end

if ( shooter and shooter ~= NULL_ENTITY ) then
	local p_s = EntityGetWithTag( 'projectile' ) or { }
	if ( #p_s > 0 ) then
		local controls = EntityGetFirstComponentIncludingDisabled( shooter, 'ControlsComponent' )
		if ( controls ) then
			local cur_x, cur_y = ComponentGetValue2( controls, 'mMousePosition' )
			if ( cur_x and cur_y ) then
				for _ = 1, #p_s do
					local p = p_s[_]

					local v_comp = EntityGetFirstComponentIncludingDisabled( p, 'VelocityComponent' )
					local px, py = EntityGetTransform( p )
					if ( v_comp ) then
						local length = 500
						local divergence = ( ( math.random( ) - 0.5 ) * 0.174533 )
						local angle = ( math.pi - math.atan( ( cur_y - py ), ( cur_x - px ) ) ) + divergence
						local vel_x = - math.cos( angle ) * length
						local vel_y = math.sin( angle ) * length
						ComponentSetValue2( v_comp, 'mVelocity', vel_x, vel_y )
					end
				end
			end
		end
	end
end
