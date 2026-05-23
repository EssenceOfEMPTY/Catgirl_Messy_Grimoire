dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

if ( is_alive( entity ) ) then
	local d_comp = EntityGetFirstComponent( entity, 'DamageModelComponent' )

	if ( d_comp ) then
		local hp, max_hp = get_comp_info( entity, 'DamageModelComponent', nil, {
			{ 'hp', 1 },
			{ 'max_hp', 1 },
		}, nil )

		if ( max_hp * get_scale( ) >= 2 and ( not EntityHasTag( entity, 'boss_centipede' ) or ( GameGetOrbCountThisRun( ) < 33 ) ) ) then
			local eff = 'effect_hearty'

			if ( not is_has_comp( entity, 'VariableStorageComponent', eff ) ) then
				add_comp_remove_dupli( entity, 'VariableStorageComponent', eff, {
					_tags = eff,
					value_float = max_hp,
				} )
			end

			max_hp = max_hp / 2.0

			if ( hp > max_hp ) then
				set_comp_value( entity, 'DamageModelComponent', nil, {
					hp = max_hp,
					max_hp = max_hp,
				}, nil, nil )
			else
				set_comp_value( entity, 'DamageModelComponent', nil, {
					max_hp = max_hp,
				}, nil, nil )
			end
		end
	end
end
