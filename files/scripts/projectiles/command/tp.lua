dofile_once( 'data/scripts/lib/utilities.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local paras = parse_and_evaluate_command_paras( 'empty_tp', entity, { 'tp_entities', 'tar', 'x', 'y' } )

	if ( paras ) then
		if ( paras.tar ) then
			empty_command_functions[ 'tp' ].action_2_paras( { }, true, paras.shooter, paras.tp_entities, paras.tar )
		end

		if ( paras.x and paras.y ) then
			empty_command_functions[ 'tp' ].action_3_paras( { }, true, paras.shooter, paras.tp_entities, paras.x, paras.y )
		end
	end
end
