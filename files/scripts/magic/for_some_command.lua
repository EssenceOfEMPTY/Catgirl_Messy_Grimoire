dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function electricity_receiver_electrified( )
	local projs, l_comps = EntityGetWithTag( 'projectile' ), { }

	add_table( projs, EntityGetWithTag( 'projectile_player' ) )

	projs = remove_duplicates( projs )

	for _, proj in ipairs( projs ) do
		local speed_comps = EntityGetComponent( proj, 'LuaComponent', 'empty_speed_set_dupli' ) or { }
		local angle_add_comps = EntityGetComponent( proj, 'LuaComponent', 'empty_shoot_angle_add_dupli' ) or { }
		local angle_set_comps = EntityGetComponent( proj, 'LuaComponent', 'empty_shoot_angle_set_dupli' ) or { }

		add_table( l_comps, speed_comps )
		add_table( l_comps, angle_add_comps )
		add_table( l_comps, angle_set_comps )
	end

	for _, l_comp in ipairs( l_comps ) do
		local script = ComponentGetValue2( l_comp, 'script_source_file' )

		dofile_once( script )
	end
end
