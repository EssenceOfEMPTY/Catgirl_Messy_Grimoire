
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )
local a, b, c = time_for_vec3( )

SetRandomSeed( x - a + c, y - b + c )

local projfile = get_comp_info( entity, 'VariableStorageComponent', 'orbit_projectile', {
	{ 'value_string', nil },
}, nil )

if ( is_not_nil_str( projfile ) ) then
	local speed = random_gets( { 1, -1 }, 1 )[ 1 ]

	set_comp_value( entity, 'VariableStorageComponent', 'orbit_projectile', {
		value_int = speed,
	}, nil, nil )

	local entities = { }

	for _ = 1, 4, 1 do
		local e = shoot_proj( entity, projfile, x + orbit_loc_fix[ _ ].x, y + orbit_loc_fix[ _ ].y, 0, 0, nil, nil, nil )

		EntityAddTag( e, 'orbit_projectile' )

		table.insert( entities, e )

		EntityAddChild( entity, e )
	end

	set_comp_value( entities, 'ProjectileComponent', nil, {
		lifetime = -1,
		die_on_low_velocity = false,
	}, nil, nil )

	remove_all_comp( entities, 'LifetimeComponent', nil )
end
