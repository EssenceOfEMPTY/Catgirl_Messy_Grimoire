dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

set_comp_value( entity, 'VelocityComponent', nil, {
	air_friction = 0,
}, nil, nil )
