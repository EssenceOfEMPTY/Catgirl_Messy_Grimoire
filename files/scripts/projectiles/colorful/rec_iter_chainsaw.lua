dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
dofile_once( empty_path .. 'scripts/empty/empty_command_utility.lua' )

local e_id = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( e_id ~= NULL_ENTITY ) then
	local p_comp = EntityGetFirstComponent( e_id, 'ProjectileComponent' )

	if ( p_comp ) then
		local paras= parse_and_evaluate_command_params( 'empty_colorful_rec_iter_projectile_chainsaw', e_id, { 'count' }, 0 )

		if ( paras) then
			local count = params[ 'count' ]

			local dmg = ComponentObjectGetValue2( p_comp, 'damage_by_type', 'slice' ) or 0
			local delta = count ^ ( 1 + get_ng_num( ) )

			dmg = dmg + delta

			ComponentObjectSetValue2( p_comp, 'damage_by_type', 'slice', dmg )
		end
	end
end
