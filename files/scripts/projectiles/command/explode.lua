dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

print( 'explode.lua: run' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	if ( EntityHasTag( entity, 'empty_explode_delay' ) ) then
		local paras = parse_and_evaluate_command_paras( 'empty_explode', entity, { 'radius', 'tar', 'x', 'y' } )

		if ( paras ) then
			if ( paras.tar ) then
				empty_command_functions[ 'explode' ].action_2_paras( { }, true, paras.shooter, paras.radius, paras.tar )
			end

			if ( paras.x and paras.y ) then
				empty_command_functions[ 'explode' ].action_3_paras( { }, true, paras.shooter, paras.radius, paras.x, paras.y )
			end
		end

		EntityKill( entity )
	else
		EntityAddTag( entity, 'empty_explode_delay' )

		ComponentSetValue2( GetUpdatedComponentID( ), 'mNextExecutionTime', GameGetFrameNum( ) )
	end
end
