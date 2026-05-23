dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, length = get_root_entity( ), 100
local x, y = EntityGetTransform( entity )

local how_many = 8
local angle_inc = p2 / how_many

GameEntityPlaySound( entity, 'duplicate' )

for _ = 1, how_many do
	local vel_x, vel_y = math.cos( ( _ - 1 ) * angle_inc ) * length, math.sin( ( _ - 1 ) * angle_inc ) * length

	shoot_proj( entity, empty_path .. 'entities/projectiles/orb_timer_circle_no_copy.xml', x, y, vel_x, vel_y, nil, nil, nil )
end
