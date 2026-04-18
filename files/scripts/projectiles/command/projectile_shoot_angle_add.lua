dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

local l_comps = EntityGetComponent( entity, 'LuaComponent', 'empty_shoot_angle_add_dupli' )

if ( entity ~= NULL_ENTITY ) then
	if ( EntityHasTag( entity, 'empty_projectile_shoot_angle_add_delay' ) ) then
		local paras = parse_and_evaluate_command_paras( 'empty_projectile_shoot_angle_add', entity, { 'angle' } )

		if ( paras ) then
			empty_command_functions[ 'projectile_shoot_angle_add' ].action_1_paras( { }, true, paras.shooter, paras.angle )
		end

		for _, l_comp in ipairs( l_comps or { } ) do
			EntityRemoveComponent( entity, l_comp )
		end
	else
		EntityAddTag( entity, 'empty_projectile_shoot_angle_add_delay' )

		ComponentSetValue2( GetUpdatedComponentID( ), 'mNextExecutionTime', GameGetFrameNum( ) )

		for _, l_comp in ipairs( l_comps or { } ) do
			if ( _ > 1 ) then
				EntityRemoveComponent( entity, l_comp )
			end
		end
	end
end
