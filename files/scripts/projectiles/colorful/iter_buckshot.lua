dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
dofile_once( empty_path .. 'scripts/empty/empty_command_utility.lua' )

local e_id = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( e_id ~= NULL_ENTITY ) then
	local p_comp = EntityGetFirstComponent( e_id, 'ProjectileComponent' )

	if ( p_comp ) then
		local params = parse_and_evaluate_command_params( 'empty_colorful_iter_projectile_buckshot', e_id, { 'count' }, 0 )

		if ( params ) then
			local count = params[ 'count' ]

			local dmg, dmg_explosion = ComponentGetValue2( p_comp, 'damage' ) or 0, ComponentObjectGetValue2( p_comp, 'config_explosion', 'damage' ) or 0
			local delta, lifetime = ( ( count ) ^ math.max( 1, get_ng_num( ) ) ) / get_scale( ), ComponentGetValue2( p_comp, 'lifetime' ) or 0

			dmg, lifetime, dmg_explosion = dmg + delta, ( 0.8 + 0.2 * count ) * lifetime, dmg_explosion + delta

			ComponentSetValue2( p_comp, 'damage', dmg )
			ComponentSetValue2( p_comp, 'lifetime', lifetime )
			ComponentObjectSetValue2( p_comp, 'config_explosion', 'damage', dmg_explosion )
		end
	end
end
