dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local proj, tag = get_root_entity( ), 'adjust'
local paras = parse_and_evaluate_command_paras( tag, proj, {
	'frames',
	'level',
}, '%' )

if ( paras ) then
	if ( is_not_0_num( paras.frames ) and is_not_0_num( paras.level ) ) then
		remove_speed_limit( proj )

		local attri = {
			speed_min = ( paras.frames * paras.level ) / max_adjust,
			speed_max = ( paras.frames * paras.level ) / max_adjust,
		}

		local mul = ( 6 + 7 * paras.level ) * ( paras.frames / max_adjust )

		local p_dmg = get_comp_info( proj, 'ProjectileComponent', nil, {
			{ 'damage', 0 },
		} )

		if ( p_dmg > 0 ) then
			attri.damage = p_dmg * mul
		end

		set_comp_value( proj, 'ProjectileComponent', nil, attri, nil, nil )

		local ex_dmg = get_comp_obj_info( proj, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'damage', 0 },
		}, nil )

		if ( ex_dmg > 0 ) then
			set_comp_obj_value( proj, 'ProjectileComponent', nil, {
				{ 'config_explosion', 'damage', ex_dmg * mul }
			}, nil, nil )
		end

		local dmg = { }

		for i, _ in ipairs( all_proj_dmg ) do
			local tmp = get_comp_obj_info( proj, 'ProjectileComponent', nil, {
				{ 'damage_by_type', _, 0 },
			}, nil )

			if ( tmp > 0 ) then
				table.insert( dmg, {
					'damage_by_type', _, tmp * mul
				} )
			end
		end

		set_comp_obj_value( proj, 'ProjectileComponent', nil, dmg, nil, nil )
	end
end
