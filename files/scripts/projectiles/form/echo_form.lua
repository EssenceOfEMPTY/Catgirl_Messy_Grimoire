dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local copy = 'echo_copy'

function shot( proj )
	if ( EntityHasTag( proj, copy ) ) then
		return
	end

	local projfile = get_comp_info( proj, 'VariableStorageComponent', nil, {
		{ 'value_string', nil }
	}, 'projectile_file' )

	if ( is_not_nil_str( projfile ) and ModDoesFileExist( projfile ) ) then
		local x, y = EntityGetTransform( proj )
		local v_comp = EntityGetFirstComponent( proj, 'VelocityComponent' ) or 0
		local vel_x, vel_y = nil, nil
		local p_comp = EntityGetFirstComponent( proj, 'ProjectileComponent' ) or 0

		if ( is_not_0_num( v_comp ) ) then
			vel_x, vel_y = ComponentGetValue2( v_comp, 'mVelocity' )
		end

		vel_x, vel_y = vel_x or 0, vel_y or 0

		local a, b, c = time_for_vec3( )
		SetRandomSeed( x - a + c, y - b + c )

		x, y = x + Random( -3, 3 ), y + Random( -3, 3 )
		vel_x, vel_y = vel_x + Random( -3, 3 ), vel_y + Random( -3, 3 )

		local e = shoot_proj( proj, projfile, x, y, vel_x, vel_y, copy )

		if ( p_comp ~= 0 ) then
			local p_dmg = ComponentGetValue2( p_comp, 'damage' )

			if ( p_dmg and p_dmg > 0 ) then
				set_comp_value( e, 'ProjectileComponent', nil, {
					damage = p_dmg,
				}, nil, nil )
			end

			local ex_dmg = ComponentObjectGetValue2( p_comp, 'config_explosion', 'damage' )

			if ( ex_dmg and ex_dmg > 0 ) then
				set_comp_obj_value( e, 'ProjectileComponent', nil, {
					{ 'config_explosion', 'damage', ex_dmg },
				}, nil, nil )
			end

			local dmg, need_set, obj = { }, false, 'damage_by_type'

			for i, v in ipairs( all_proj_dmg ) do
				local _ = ComponentObjectGetValue2( p_comp, obj, v )

				if ( _ and _  > 0 ) then
					table.insert( dmg, {
						obj, v, _
					} )

					need_set = true
				end
			end

			if ( need_set ) then
				set_comp_obj_value( e, 'ProjectileComponent', nil, dmg, nil, nil )
			end
		end
	end

	--local l_comps = get_all_comp( proj, 'LuaComponent', nil )
--
	--if ( #l_comps > 0 ) then
	--	--
	--end
end
