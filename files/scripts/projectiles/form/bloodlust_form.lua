dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function shot( proj )
	if ( is_has_comp( proj, 'ProjectileComponent', nil ) ) then
		local mul = 3.25

		set_comp_value( proj, 'ProjectileComponent', nil, nil, function ( comp )
			local p_dmg = ComponentGetValue2( comp, 'damage' )

			if ( p_dmg and p_dmg > 0 ) then
				ComponentSetValue2( comp, 'damage', mul * p_dmg )
			end
		end, nil )

		set_comp_obj_value( proj, 'ProjectileComponent', nil, nil, function ( comp )
			local ex_dmg = ComponentObjectGetValue2( comp, 'config_explosion', 'damage' )

			if ( ex_dmg and ex_dmg > 0 ) then
				ComponentObjectSetValue2( comp, 'config_explosion', 'damage', mul * ex_dmg )
			end
		end, nil )

		set_comp_obj_value( proj, 'ProjectileComponent', nil, nil, function ( comp )
			for i, _ in ipairs( all_proj_dmg ) do
				local d_mul = ComponentObjectGetValue2( comp, 'damage_by_type', _ )

				if ( d_mul and d_mul > 0 ) then
					ComponentObjectSetValue2( comp, 'damage_by_type', _, mul * d_mul )
				end
			end
		end, nil )
	end
end
