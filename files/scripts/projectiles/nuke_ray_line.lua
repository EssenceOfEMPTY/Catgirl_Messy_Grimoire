dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )
local vel_x, vel_y = nil, nil
local v_comp = EntityGetFirstComponent( entity, 'VelocityComponent' )

if ( is_not_0_num( v_comp ) ) then
	vel_x, vel_y = ComponentGetValue2( v_comp or 0, 'mVelocity' )
end

if ( vel_x and vel_y ) then
	local angle, length = -math.atan( vel_y, vel_x ), 1600

	local angle_fix = angle + math.pi * 0.5
	vel_x, vel_y = math.cos( angle_fix ) * length, -math.sin( angle_fix ) * length

	shoot_proj( entity, 'data/entities/projectiles/deck/nuke.xml', x, y, vel_x, vel_y, nil, nil, nil )

	angle_fix = angle - math.pi * 0.5
	vel_x, vel_y = math.cos( angle_fix ) * length, -math.sin( angle_fix ) * length

	shoot_proj( entity, 'data/entities/projectiles/deck/nuke.xml', x, y, vel_x, vel_y, nil, nil, nil )
end
