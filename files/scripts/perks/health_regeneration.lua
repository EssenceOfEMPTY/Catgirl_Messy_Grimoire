dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )

local cur_hp, max_hp = get_comp_info( entity, 'DamageModelComponent', nil, {
	{ 'hp', -1 },
	{ 'max_hp', -1 }
}, nil )

if ( cur_hp < max_hp ) then
	local heal = math.min( max_hp - cur_hp, 0.015 * max_hp )

	if ( heal > 0 ) then
		EntityInflictDamage( entity, -heal, 'DAMAGE_HEALING', '', 'NONE', 0, 0, entity )

		EntityLoad( 'data/entities/particles/heal.xml', x, y )
	end
end
