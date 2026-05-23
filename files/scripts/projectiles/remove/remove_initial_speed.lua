dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

set_comp_value( entity, 'ProjectileComponent', nil, nil, function ( comp )
	local time = ComponentGetValue2( comp, 'lifetime' )

	if ( time > 0 ) then
		ComponentSetValue2( comp, 'lifetime', 3 * time )
	end
end, nil )

set_comp_value( entity, 'LifetimeComponent', nil, nil, function ( comp )
	local time = ComponentGetValue2( comp, 'lifetime' )

	if ( time > 0 ) then
		ComponentSetValue2( comp, 'lifetime', 3 * time )
	end
end, nil )
