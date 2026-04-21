dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( 'empty_projectile_speed_set', entity, { 'speed' } )
	local l_comps = EntityGetComponent( entity, 'LuaComponent', 'empty_speed_set_dupli' )

	if ( not EntityHasTag( entity, 'empty_projectile_speed_set_delay' ) ) then
		EntityAddTag( entity, 'empty_projectile_speed_set_delay' )

		ComponentSetValue2( GetUpdatedComponentID( ), 'mNextExecutionTime', GameGetFrameNum( ) )

		if ( paras ) then
			local p_comps = EntityGetComponent( entity, 'ProjectileComponent' ) or { }

			for _, p_comp in ipairs( p_comps ) do
				ComponentSetValue2( p_comp, 'speed_min', paras.speed )
				ComponentSetValue2( p_comp, 'speed_max', paras.speed )
			end

			local v_comps = EntityGetComponent( entity, 'VelocityComponent' ) or { }

			remove_speed_limit( v_comps )
		end

		for _, l_comp in ipairs( l_comps or { } ) do
			if ( l_comp ~= GetUpdatedComponentID( ) ) then
				EntityRemoveComponent( entity, l_comp )
			end
		end

		return
	end

	EntityRemoveTag( entity, 'empty_projectile_speed_set_delay' )

	if ( paras ) then
		empty_command_functions[ 'projectile_speed_set' ].action_1_paras( { }, true, paras.shooter, paras.speed )
	end

	for _, l_comp in ipairs( l_comps or { } ) do
		EntityRemoveComponent( entity, l_comp )
	end
end
