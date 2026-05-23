dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

remove_all_comp( entity, 'AudioComponent', nil )
remove_all_comp( entity, 'AudioLoopComponent', nil )
