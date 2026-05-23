dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

if ( is_alive( entity ) ) then
	local v_comps = get_all_comp( entity, 'VariableStorageComponent', 'effect_hearty' )

	for _, v_comp in ipairs( v_comps ) do
		if ( _ == 1 ) then
			local log_max_hp = ComponentGetValue2( v_comp, 'value_float' )

			set_comp_value( entity, 'DamageModelComponent', nil, {
				max_hp = log_max_hp,
			}, nil, nil )
		end

		EntityRemoveComponent( entity, v_comp )
	end
end
