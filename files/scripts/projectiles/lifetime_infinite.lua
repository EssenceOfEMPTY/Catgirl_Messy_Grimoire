dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

set_comp_value( entity, 'ProjectileComponent', nil, {
	friendly_fire = true,
	collide_with_shooter_frames = 60,
	lifetime = -1,
}, nil, nil )

remove_all_comp( entity, 'LifetimeComponent', nil )
