dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local proj = get_root_entity( )

if ( is_not_0_num( proj ) ) then
	local paras = parse_and_evaluate_command_paras( 'colorful_rec_iter_projectile_chainsaw', proj, { 'count' } )

	if ( paras and paras.count ) then
		local count = paras.count

		local dmg = get_comp_obj_info( proj, 'ProjectileComponent', nil, {
			{ 'damage_by_type', 'slice', 1 / get_scale( ) },
		}, nil )

		set_comp_obj_value( proj, 'ProjectileComponent', nil, {
			{ 'damage_by_type', 'slice', dmg + count ^ ( 1 + get_ng_count( ) ) }
		}, nil, nil )
	end
end
