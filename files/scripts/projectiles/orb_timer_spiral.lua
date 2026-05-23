dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, length = get_root_entity( ), 100
local x, y = EntityGetTransform( entity )

local angle = deg_to_rad( GameGetFrameNum( ) ) * 3
local vel_x, vel_y = math.cos( angle ) * length, -math.sin( angle ) * length

GameEntityPlaySound( entity, 'duplicate' )

shoot_proj( entity, empty_path .. 'entities/projectiles/orb_timer_spiral_no_copy.xml', x, y, vel_x, vel_y, nil, nil, nil )
